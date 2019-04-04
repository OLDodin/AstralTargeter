local m_reactions={}
local m_template = createWidget(nil, "Template", "Template")

function AddReaction(name, func)
	if not m_reactions then m_reactions={} end
	m_reactions[name]=func
end

local function RunReaction(widget)
	local name=getName(widget)
	if name == "GetModeBtn" then
		name=getName(getParent(widget))
	end
	if not name or not m_reactions or not m_reactions[name] then return end
	m_reactions[name](widget)
end

local function ButtonPressed(params)
	RunReaction(params.widget)
	changeCheckBox(params.widget)
end

local m_targetSubSystemLoaded = false

local m_targetPanel = nil
local m_targeterPlayerPanelList = {}
local m_lastTargetPanelSize = {}

local TARGETS_LIMIT = 12
local m_currTargetType = ALL_TARGETS
local m_lastTargetType = ALL_TARGETS
local m_targetUnitsByType = {}


function GetIndexForWidget(anWidget)
	local parent = getParent(anWidget)
	local container = getParent(getParent(getParent(parent)))
	if not parent or not container then 
		return nil
	end
	local index = nil
	for i=0, container:GetElementCount() do
		if equals(anWidget, getChild(container:At(i), getName(anWidget), true)) then index=i end
	end
	return index
end

local function GenerateWidgetForTable(aTable, aContainer, anIndex)
	setTemplateWidget(m_template)
	local panel=createWidget(aContainer, nil, "Panel", WIDGET_ALIGN_BOTH, WIDGET_ALIGN_LOW, nil, 30, nil, nil, true)
	setBackgroundColor(panel, {r=1, g=1, b=1, a=0.5})
	setText(createWidget(panel, "Id", "TextView", WIDGET_ALIGN_LOW, WIDGET_ALIGN_CENTER, 30, 20, 10), anIndex)
	if aTable.name then
		local nameWidget=createWidget(panel, "Name"..tostring(anIndex), "EditLine", WIDGET_ALIGN_LOW, WIDGET_ALIGN_CENTER, 200, 20, 35)
		setText(nameWidget, aTable.name)
		setBackgroundTexture(nameWidget, nil)
		setBackgroundColor(nameWidget, nil)
	end
	local containerParentName = getName(getParent(aContainer))
	
	if containerParentName then
		if compare(containerParentName, "buffSettingsForm") then
			setText(createWidget(panel, "editButton"..containerParentName, "Button", WIDGET_ALIGN_HIGH, WIDGET_ALIGN_CENTER, 15, 15, 30), "e")
		end
		setText(createWidget(panel, "deleteButton"..containerParentName, "Button", WIDGET_ALIGN_HIGH, WIDGET_ALIGN_CENTER, 15, 15, 10), "x")
	end
	return panel
end

function ShowValuesFromTable(aTable, aForm, aContainer)
	local container = aContainer
	if not aContainer then 
		container = getChild(aForm, "container") 
	end

	if not aTable or not container then 
		return nil 
	end
	
	if container.RemoveItems then 
		container:RemoveItems() 
	end
	for i, element in ipairs(aTable) do
		if container.PushBack then
			local widget=GenerateWidgetForTable(element, container, i)
			if widget then 
				container:PushBack(widget) 
			end
		end
	end
end

local function DeleteContainer(aTable, anWidget, aForm)
	local parent = getParent(anWidget)
	local container = getParent(getParent(getParent(parent)))
	local index = GetIndexForWidget(anWidget)
	if container and index and aTable then
		container:RemoveAt(index)
		table.remove(aTable, index+1)
	end
	ShowValuesFromTable(aTable, aForm, container)
end

function UpdateTableValuesFromContainer(aTable, aForm, aContainer)
	local container = aContainer
	if not aContainer then 
		container = getChild(aForm, "container") 
	end
	if not container or not aTable then 
		return nil 
	end
	for i, j in ipairs(aTable) do
		j.name=getText(getChild(container, "Name"..tostring(i), true))
	end
end

function AddElementFromForm(aTable, aForm, aTextedit, aContainer)
	if not aTextedit then aTextedit="EditLine1" end
	local text = getText(getChild(aForm, aTextedit))
	local textLowerStr = toLowerString(text)
	if not aTable or not text or common.IsEmptyWString(text) then 
		return nil 
	end
	table.insert(aTable, { name=text, nameLowerStr=textLowerStr } )
	ShowValuesFromTable(aTable, aForm, aContainer)
end


function SaveAll()
	SaveProfile(GetCurrentProfile())
end


local function FindClickedInTarget(anWdg)
	for i=0, GetTableSize(m_targeterPlayerPanelList)-1 do
		local playerBar = m_targeterPlayerPanelList[i]
		if playerBar.isUsed and anWdg:IsEqual(playerBar.wdg) then
			return playerBar
		end
	end
end

function TargetChanged()
	local targetID = avatar.GetObservedTransport() or avatar.GetObservedAstralUnit()
	local profile = GetCurrentProfile()

	if profile.targeterFormSettings.highlightSelectedButton then
		for i=0, GetTableSize(m_targeterPlayerPanelList)-1 do
			local playerBar = m_targeterPlayerPanelList[i]
			if targetID and playerBar.isUsed and playerBar.playerID and targetID == playerBar.playerID then
				PlayerTargetsHighlightChanged(true, playerBar)
			elseif playerBar.highlight then
				PlayerTargetsHighlightChanged(false, playerBar)
			end
		end
	end
end

local function OnPlayerSelect(aParams, aLeftClick)
	local playerBar = nil
	if aLeftClick then
		playerBar = FindClickedInTarget(aParams.widget)
		if playerBar then
			local deviceId = avatar.GetActiveUsableDevice()
			if deviceId and device.GetUsableDeviceType(deviceId) == USDEV_NAVIGATOR then
				local currTarget = device.NavigatorGetTarget()
				if currTarget == playerBar.playerID then
					device.NavigatorSetTarget( nil )
				else
					device.NavigatorSetTarget( playerBar.playerID )
				end
			end
		end
	end
	
	
end

local function OnLeftClick(aParams)
	OnPlayerSelect(aParams, true)
end

local function OnRightClick(aParams)
	OnPlayerSelect(aParams, false)
end

local function TargetLockChanged(aParams)
	TargetLockBtn(m_targetPanel)
end


local function ResizePanelForm(aGroupsCnt, aMaxPeopleCnt, aFormSettings, aForm, aLastSize)
	local panelWidth = tonumber(aFormSettings.raidWidthText)
	local panelHeight = tonumber(aFormSettings.raidHeightText)
	local width = 0
	local height = 30
	if aFormSettings.gorisontalModeButton then
		width = width + aMaxPeopleCnt*panelWidth
		height = height + aGroupsCnt*panelHeight
	else 
		width = width + aGroupsCnt*panelWidth
		height = height + aMaxPeopleCnt*panelHeight
	end
	if aLastSize.w ~= width or aLastSize.h ~= height then
		resize(aForm, math.max(200, width), height)
		aLastSize.w = width
		aLastSize.h = height
	end
end

local function ResizeTargetPanel(aGroupsCnt, aMaxPeopleCnt)
	local profile = GetCurrentProfile()
	ResizePanelForm(aGroupsCnt, aMaxPeopleCnt, profile.targeterFormSettings, m_targetPanel, m_lastTargetPanelSize)
end

local function EraseTargetInListTarget(anObjID, aType)
	local objArr = m_targetUnitsByType[aType]
	for i=1, GetTableSize(objArr) do
		if objArr[i].objID == anObjID then
			table.remove(objArr, i)
			return
		end
	end
	
end

local function EraseTarget(anObjID)
	EraseTargetInListTarget(anObjID, ENEMY_SHIPS_TARGETS)
	EraseTargetInListTarget(anObjID, FRIEND_SHIPS_TARGETS)
	EraseTargetInListTarget(anObjID, ENEMY_MOBS_TARGETS)
	EraseTargetInListTarget(anObjID, FRIEND_MOBS_TARGETS)
end

local function FindInListTarget(anObjID, anObjArr)
	for i=1, GetTableSize(anObjArr) do
		if anObjArr[i].objID == anObjID then
			return true
		end
	end
	return false
end

local function FindTarget(anObjID)
	local res = FindInListTarget(anObjID, m_targetUnitsByType[ENEMY_SHIPS_TARGETS])
	res = res or FindInListTarget(anObjID, m_targetUnitsByType[FRIEND_SHIPS_TARGETS])
	res = res or FindInListTarget(anObjID, m_targetUnitsByType[ENEMY_MOBS_TARGETS])
	res = res or FindInListTarget(anObjID, m_targetUnitsByType[FRIEND_MOBS_TARGETS])
	
	return res
end

local function AddTargetInList(aNewTargetInfo, anObjArr)
	if not anObjArr then
		return
	end
	
	table.insert(anObjArr, aNewTargetInfo)
end

local function SetNecessaryTargets(anObjID, anInCombat)
	
	local profile = GetCurrentProfile()
	local isTransport = object.IsTransport(anObjID)
	
	local isEnemy = object.IsEnemy(anObjID)
	local isFriend = not isEnemy
	
	local newValue = {}
	newValue.objID = anObjID
	newValue.inCombat = anInCombat

	newValue.objName = object.GetName(newValue.objID)
	newValue.objNameLower = toLowerString(newValue.objName)

	if profile.targeterFormSettings.sortByClass then
		if isTransport then 
			newValue.classPriority = g_classPriority["SHIP"]
		else
			newValue.classPriority = g_classPriority["UNIT"]
		end
	end
	
	if profile.targeterFormSettings.sortByHP then
		local healthInfo = object.GetHealthInfo(anObjID)
		newValue.hp = healthInfo and healthInfo.valuePercents
	end
	if isEnemy then
		newValue.relationType = ENEMY_PANEL
	else
		newValue.relationType = FRIEND_PANEL
	end

	local objArr = nil

	if isTransport then
		if isEnemy then
			objArr = m_targetUnitsByType[ENEMY_SHIPS_TARGETS]
		else
			objArr = m_targetUnitsByType[FRIEND_SHIPS_TARGETS]
		end
	end
	AddTargetInList(newValue, objArr)
	objArr = nil
	if not isTransport then
		if isEnemy then
			objArr = m_targetUnitsByType[ENEMY_MOBS_TARGETS]
		else
			objArr = m_targetUnitsByType[FRIEND_MOBS_TARGETS]
		end
	end
	AddTargetInList(newValue, objArr)
end

local function CreateTargeterPanelCache()
	local profile = GetCurrentProfile()

	TARGETS_LIMIT = tonumber(profile.targeterFormSettings.targetLimit)

		
	for i = 0, TARGETS_LIMIT-1 do
		local playerPanel = CreatePlayerPanel(m_targetPanel, 0, i, false, profile.targeterFormSettings)
		m_targeterPlayerPanelList[i] = playerPanel
		if profile.targeterFormSettings.twoColumnMode then
			align(playerPanel.wdg, WIDGET_ALIGN_HIGH, WIDGET_ALIGN_LOW)
		end
	end
	
	for i = TARGETS_LIMIT, TARGETS_LIMIT*2-1 do
		local playerPanel = CreatePlayerPanel(m_targetPanel, 1, i, false, profile.targeterFormSettings)
		m_targeterPlayerPanelList[i] = playerPanel
		if profile.targeterFormSettings.twoColumnMode then
			align(playerPanel.wdg, WIDGET_ALIGN_HIGH, WIDGET_ALIGN_LOW)
		end
	end
end

local function ClearTargetPanels()
	UnsubscribeTargetListener()
	
	for i = 0, GetTableSize(m_targeterPlayerPanelList)-1 do
		local playerBar = m_targeterPlayerPanelList[i]
		hide(playerBar.wdg)
		playerBar.playerID = nil
	end
	
	FabricDestroyUnused()
end

local function GetAstroList()
	local resultList = {}
	local list1 = astral.GetObjects()
	local list2 = avatar.GetTransportList()
	local list3 = astral.GetUnits()
	
	if list1 then
		for _, objID in pairs(list1) do
			if isExist(objID) then
				table.insert(resultList, objID)
			end
		end
	end
	if list2 then
		for _, objID in pairs(list2) do
			if isExist(objID) then
				table.insert(resultList, objID)
			end
		end
	end
	if list3 then
		for _, objID in pairs(list3) do
			if isExist(objID) then
				table.insert(resultList, objID)
			end
		end
	end
	
	return resultList
end

local function LoadTargeterData()	
	if m_currTargetType == TARGETS_DISABLE then
		return
	end
	
	m_targetUnitsByType[ENEMY_SHIPS_TARGETS] = {}
	m_targetUnitsByType[FRIEND_SHIPS_TARGETS] = {}
	m_targetUnitsByType[ENEMY_MOBS_TARGETS] = {}
	m_targetUnitsByType[FRIEND_MOBS_TARGETS] = {}
	
	local profile = GetCurrentProfile()
	local isCombat = false
	local unitList = GetAstroList()
	
	for _, objID in pairs(unitList) do
		if profile.targeterFormSettings.twoColumnMode then
			isCombat = object.IsInCombat(objID)
		end
		SetNecessaryTargets(objID, isCombat)
	end
	
	SetTargetType(m_currTargetType, true)
end

local function TargetWorkSwitch()
	local profile = GetCurrentProfile()
	if m_currTargetType ~= TARGETS_DISABLE then
		m_lastTargetType = m_currTargetType
		m_currTargetType = TARGETS_DISABLE
		ResizeTargetPanel(1, 0)
		SwitchTargetsBtn(TARGETS_DISABLE)
		ClearTargetPanels()
		
		profile.targeterFormSettings.lastTargetType = m_lastTargetType
		profile.targeterFormSettings.lastTargetWasActive = false
		SaveAll()
	else
		m_currTargetType = m_lastTargetType
		LoadTargeterData()
		
		profile.targeterFormSettings.lastTargetWasActive = true
		SaveAll()
	end
end

local function TargetTypeChanged()
	if m_currTargetType == TARGETS_DISABLE then
		return
	end
	
	m_currTargetType = m_currTargetType + 1
	if m_currTargetType > FRIEND_MOBS_TARGETS then
		m_currTargetType = ALL_TARGETS
	end
	SetTargetType(m_currTargetType, true)
	local profile = GetCurrentProfile()
	profile.targeterFormSettings.lastTargetType = m_currTargetType
	SaveAll()
end	

local function SeparateTargeterPanelList(anObjList, aPanelListShift)
	local finededList = {} 
	local freeList = {}
	for i = aPanelListShift, TARGETS_LIMIT+aPanelListShift-1 do
		local playerBar = m_targeterPlayerPanelList[i]
		local found = false
		for k = 1, GetTableSize(anObjList) do
			if playerBar.playerID == anObjList[k].objID
			and (playerBar.formSettings.classColorModeButton or playerBar.panelColorType == anObjList[k].relationType)
			then
				finededList[playerBar.playerID] = playerBar
				found = true
				break
			end			
		end
		if not found then
			table.insert(freeList, playerBar)
		end
	end
	return finededList, freeList
end

local function SortByName(A, B)
	return A.objNameLower < B.objNameLower
end

local function SortByHP(A, B)
	return A.hp < B.hp
end

local function SortByClass(A, B)
	return A.classPriority < B.classPriority
end

local function SortByWeight(A, B)
	return A.sortWeight < B.sortWeight
end

local function SortBySettings(anArr)
	local profile = GetCurrentProfile()
	
	for i = 1, GetTableSize(anArr)  do
		anArr[i].sortWeight = 0
	end
		
	if profile.targeterFormSettings.sortByName then
		table.sort(anArr, SortByName)
		for i = 1, GetTableSize(anArr) do
			anArr[i].sortWeight = i
		end
	end
	
	if profile.targeterFormSettings.sortByHP then
		table.sort(anArr, SortByHP)
		for i = 1, GetTableSize(anArr) do
			anArr[i].sortWeight = anArr[i].sortWeight + anArr[i].hp * TARGETS_LIMIT
		end
	end
	
	if profile.targeterFormSettings.sortByClass then
		local shiftMult = 101 * TARGETS_LIMIT
		table.sort(anArr, SortByClass)
		for i = 1, GetTableSize(anArr) do
			anArr[i].sortWeight = anArr[i].sortWeight + anArr[i].classPriority * shiftMult
		end
	end
	
	table.sort(anArr, SortByWeight)
end

local function SortAndSetTarget(aTargetUnion, aPanelListShift, aPanelPosShift)
	local cnt = 0
	local listOfObjToUpdate = {}
	local newTargeterPlayerPanelList = {}
	local listOfObjForType = {}
	local profile = GetCurrentProfile()
	local playerBar = nil
	--формируем список для отображения
	for _, unitsByType in ipairs(aTargetUnion) do
		SortBySettings(unitsByType)
		for _, targetInfo in pairs(unitsByType) do
			local objID = targetInfo.objID
			if cnt < TARGETS_LIMIT and isExist(objID) then
				table.insert(listOfObjForType, targetInfo)
				cnt = cnt + 1
			end
		end
	end
	--находим панели уже отображаемых игроков
	local reusedPanels, freePanels = SeparateTargeterPanelList(listOfObjForType, aPanelListShift)
	local freePanelInd = 1
	cnt = aPanelListShift
	--собираем панели в новом порядке, используя как подходящие так и обновляя инфу
	for _, targetInfo in ipairs(listOfObjForType) do
		local objID = targetInfo.objID
		playerBar = reusedPanels[objID]
		if not playerBar then
			playerBar = freePanels[freePanelInd]
			freePanelInd = freePanelInd + 1
			if playerBar.playerID then
				UnsubscribeTargetListener(playerBar.playerID)
			end
			local updateInfo = {}
			updateInfo.playerBar = playerBar
			updateInfo.objID = objID
			updateInfo.objName = targetInfo.objName
			updateInfo.relationType = targetInfo.relationType
			table.insert(listOfObjToUpdate, updateInfo)
		end
		playerBar.isUsed = true
		m_targeterPlayerPanelList[cnt] = playerBar

		cnt = cnt + 1
	end
	--в список всех панелей добавляем все оставшиеся
	for _, bar in pairs(freePanels) do
		if not bar.isUsed then
			m_targeterPlayerPanelList[cnt] = bar
			cnt = cnt + 1
		end
	end
	--обновляем инфу на панелях
	for _, updateInfo in pairs(listOfObjToUpdate) do
		local playerInfo = {}
		playerInfo.id = updateInfo.objID
		playerInfo.name = updateInfo.objName

		SetBaseInfoPlayerPanel(updateInfo.playerBar, playerInfo, false,  profile.targeterFormSettings, updateInfo.relationType)
		FabricMakeTargetPlayerInfo(playerInfo.id, updateInfo.playerBar)
	end

	--расставляем панели и скрываем не используемые
	for i = aPanelListShift, TARGETS_LIMIT+aPanelListShift-1 do
		playerBar = m_targeterPlayerPanelList[i]
		
		ResetPlayerPanelPosition(playerBar, aPanelPosShift, i-aPanelListShift, profile.targeterFormSettings)
		if not playerBar.isUsed then
			if playerBar.playerID then
				UnsubscribeTargetListener(playerBar.playerID)
				hide(playerBar.wdg)
			end
			playerBar.playerID = nil
		end
	end
	return cnt-aPanelListShift
end

local function GetArrByCombatStatus(aStatus, aType)
	local objArr = m_targetUnitsByType[aType]
	local resultArr = {}
	for i=1, GetTableSize(objArr) do
		if objArr[i].inCombat == aStatus then
			table.insert(resultArr, objArr[i])
		end
	end
	return resultArr
end

local function MakeTargetUnion(aType, aStatus)
	local targetUnion = {}

	if aType == ALL_TARGETS then
		table.insert(targetUnion, GetArrByCombatStatus(aStatus, ENEMY_SHIPS_TARGETS))
		table.insert(targetUnion, GetArrByCombatStatus(aStatus, FRIEND_SHIPS_TARGETS))
		table.insert(targetUnion, GetArrByCombatStatus(aStatus, ENEMY_MOBS_TARGETS))
		table.insert(targetUnion, GetArrByCombatStatus(aStatus, FRIEND_MOBS_TARGETS))
	elseif aType == ENEMY_TARGETS then
		table.insert(targetUnion, GetArrByCombatStatus(aStatus, ENEMY_SHIPS_TARGETS))
		table.insert(targetUnion, GetArrByCombatStatus(aStatus, ENEMY_MOBS_TARGETS))
	elseif aType == FRIEND_TARGETS then
		table.insert(targetUnion, GetArrByCombatStatus(aStatus, FRIEND_SHIPS_TARGETS))
		table.insert(targetUnion, GetArrByCombatStatus(aStatus, FRIEND_MOBS_TARGETS))
	else
		table.insert(targetUnion, GetArrByCombatStatus(aStatus, aType))
	end
	return targetUnion
end
	
function SetTargetType(aType, anIsTypeChanged)
	if m_currTargetType == TARGETS_DISABLE then
		return
	end
	if anIsTypeChanged then
		SwitchTargetsBtn(aType)
	end
	local profile = GetCurrentProfile()
	for i = 0, GetTableSize(m_targeterPlayerPanelList)-1 do
		m_targeterPlayerPanelList[i].isUsed = false
	end
	
	local targetUnion = MakeTargetUnion(aType, false)
	
	
	local targetUnionCombat = {}
	if profile.targeterFormSettings.twoColumnMode then
		targetUnionCombat = MakeTargetUnion(aType, true)
	end
	
	local cntSimple = 0
	local cntCombat = 0
	if profile.targeterFormSettings.twoColumnMode then
		cntSimple = SortAndSetTarget(targetUnion, 0, 0)
		cntCombat = SortAndSetTarget(targetUnionCombat, TARGETS_LIMIT, 1)
	else
		cntSimple = SortAndSetTarget(targetUnion, 0, 0)
	end

	local maxPeopleCnt = math.min(math.max(cntSimple, cntCombat), TARGETS_LIMIT)
	FabricDestroyUnused()
	if profile.targeterFormSettings.twoColumnMode then
		ResizeTargetPanel(2, maxPeopleCnt)
	else
		ResizeTargetPanel(1, maxPeopleCnt)
	end
	TargetChanged()
end


local function InitTargeterData()	
	local profile = GetCurrentProfile()
	m_lastTargetType = profile.targeterFormSettings.lastTargetType
	
	if profile.targeterFormSettings.lastTargetWasActive then
		m_currTargetType = TARGETS_DISABLE
	else
		m_currTargetType = m_lastTargetType
	end
	
	SwitchTargetsBtn(m_currTargetType)
	
end

local function UnitHPChanged(aParams)
	local profile = GetCurrentProfile()
	if not profile.targeterFormSettings.sortByHP then
		return
	end
	local playerID = aParams.unitId or aParams.id
	if isExist(playerID) then
		-- пока не получили EVENT_UNITS_CHANGED данные по могут быть невалидными
		if FindTarget(playerID) then
			EraseTarget(playerID)
			local isCombat = false
			if profile.targeterFormSettings.twoColumnMode then
				isCombat = object.IsInCombat(playerID)
			end
			SetNecessaryTargets(playerID, isCombat)
			SetTargetType(m_currTargetType)
		end
	end
end

local function UnitSpawned(aParams)
	if m_targetSubSystemLoaded then
		if m_currTargetType == TARGETS_DISABLE then
			return
		end
		local objID = aParams.objectId or aParams.id or aParams.unitId
--		LogInfo("objID = ", objID, ' aParams.objectId = ', aParams.objectId or " " , " aParams.id = ", aParams.id or " ", " aParams.unitId = ", aParams.unitId)
		if isExist(objID) and  objID then
			local isCombat = false
			local profile = GetCurrentProfile()
			if profile.targeterFormSettings.twoColumnMode then
				isCombat = object.IsInCombat(objID)
			end
			EraseTarget(objID)
			SetNecessaryTargets(objID, isCombat)
		end

		SetTargetType(m_currTargetType)
	end
end

local function UnitDespawned(aParams)
	if m_targetSubSystemLoaded then
		if m_currTargetType == TARGETS_DISABLE then
			return
		end
		local objID = aParams.objectId or aParams.id or aParams.unitId	
		if objID then
			EraseTarget(objID)
		end
			
		SetTargetType(m_currTargetType)
	end
end

local function AvatarShipChanged()
	local myShipID = unit.GetTransport(avatar.GetId())
	if myShipID then
		show(m_targetPanel)
		
		UnitRelativityDirPosChanged({id = myShipID})
	else
		hide(m_targetPanel)
	end
end

local function GUIInit()
	CreateMainBtn()
	
	m_targetPanel = CreateTargeterPanel()
end

local function Update()
	updateCachedTimestamp()
	UpdateFabric()
end


function InitTargeterSubSystem(aReload)
	if m_targetSubSystemLoaded then
		UnloadTargeterSubSystem()
	end
	m_targetSubSystemLoaded = true
	CreateTargeterPanelCache()
	
	show(m_targetPanel)
	InitTargeterData()
	TargetWorkSwitch()
end

function UnloadTargeterSubSystem()
	if not m_targetSubSystemLoaded then
		return
	end
	m_targetSubSystemLoaded = false
	

	ClearTargetPanels()
	m_targeterPlayerPanelList = {}
	hide(m_targetPanel)
end

function ATButtonPressed()
	swap(m_targetPanel)
end

function GUIControllerInit()
	GUIInit()
	
	LoadSettings()
	
	common.RegisterReactionHandler(ButtonPressed, "execute")
	
	AddReaction("closeButton", function (aWdg) swap(getParent(aWdg)) end)
	AddReaction("ATButton", ATButtonPressed)

	InitBuffConditionMgr()
	
	InitTargeterSubSystem()
	TargetChanged()
	AvatarShipChanged()
	
	
	startTimer("updateTimer", "EVENT_UPDATE_TIMER", 0.1)
	common.RegisterEventHandler(Update, "EVENT_UPDATE_TIMER")
	
	common.RegisterEventHandler(TargetChanged, "EVENT_TRANSPORT_OBSERVING_STARTED")
	common.RegisterEventHandler(TargetChanged, "EVENT_TRANSPORT_OBSERVING_FINISHED")
	
	common.RegisterEventHandler(UnitSpawned, "EVENT_ASTRAL_OBJECT_SPAWNED")
	common.RegisterEventHandler(UnitDespawned, "EVENT_ASTRAL_OBJECT_DESPAWNED")
	common.RegisterEventHandler(UnitSpawned, "EVENT_TRANSPORT_SPAWNED")
	common.RegisterEventHandler(UnitDespawned, "EVENT_TRANSPORT_DESPAWNED")
	common.RegisterEventHandler(UnitSpawned, "EVENT_ASTRAL_UNIT_SPAWNED")
	common.RegisterEventHandler(UnitDespawned, "EVENT_ASTRAL_UNIT_DESPAWNED")
	common.RegisterEventHandler(AvatarShipChanged, "EVENT_AVATAR_TRANSPORT_CHANGED")
	
	common.RegisterEventHandler(BuffsChanged, "EVENT_OBJECT_BUFFS_ELEMENT_CHANGED")
	
	
	common.RegisterEventHandler(UnitHPChanged, "EVENT_UNIT_HEALTH_CHANGED")
	common.RegisterEventHandler(UnitHPChanged, "EVENT_OBJECT_HEALTH_CHANGED")
	
	--при изменении позиции и поворота моего корабля нужно пересчитать относительную позицию остальных
	common.RegisterEventHandler(UnitRelativityDirPosChanged, "EVENT_TRANSPORT_DIRECTION_CHANGED")
	common.RegisterEventHandler(UnitRelativityDirPosChanged, "EVENT_ASTRAL_UNIT_POS_CHANGED")
	common.RegisterEventHandler(UnitRelativityDirPosChanged, "EVENT_TRANSPORT_POS_CHANGED")



	
	common.RegisterReactionHandler(OnLeftClick, "OnLeftClick")
	common.RegisterReactionHandler(OnRightClick, "OnRightClick" )
	common.RegisterReactionHandler(TargetTypeChanged, "GetModeBtnReaction")
	common.RegisterReactionHandler(TargetWorkSwitch, "GetModeBtnRightClick")
	common.RegisterReactionHandler(TargetLockChanged, "OnTargetLockChanged")

end