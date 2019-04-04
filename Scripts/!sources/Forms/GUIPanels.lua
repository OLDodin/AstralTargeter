Global("FRIEND_PANEL", 1)
Global("NEITRAL_PANEL", 2)
Global("ENEMY_PANEL", 3)

Global("g_classPriority", {
	["SHIP"]		= 2,
	["UNIT"]		= 1
})

local m_template = createWidget(nil, "Template", "Template")


local m_relationColors={
	[FRIEND_PANEL]		= { r = 0.1; g = 0.65; b = 0.1; a = 1.0 },
	[ENEMY_PANEL]		= { r = 0.7; g = 0; b = 0; a = 1 },
	[NEITRAL_PANEL]		= { r = 0.8; g = 0.8; b = 0.1; a = 1 },
}

local m_emptyWStr = common.GetEmptyWString()


local function SetArrowAngle(anArrowIcon, anAngle)
	if anAngle and anArrowIcon then
		local curAngle = anArrowIcon:GetRotation()
		if curAngle ~= anAngle then
			anArrowIcon:PlayRotationEffect(curAngle, anAngle, 200, EA_MONOTONOUS_INCREASE)
		end
	end
end

local function PlayerHPChanged(anInfo, aPlayerBar)
	if aPlayerBar.optimizeInfo.currHP == anInfo then
		return
	end

	aPlayerBar.optimizeInfo.currHP = anInfo
	local d = anInfo/100
	local newPanelW = tonumber(aPlayerBar.formSettings.raidWidthText) * d-2
	newPanelW = math.max(newPanelW, 1)
	resize(aPlayerBar.barWdg, newPanelW)
	--[[if aPlayerBar.formSettings.raidBuffs.colorDebuffButton then
		resize(aPlayerBar.clearBarWdg, newPanelW)
	end]]
end

local function PlayerDistanceChanged(anInfo, aPlayerBar)
	if anInfo.visibleChanged then
		if anInfo.needShow then
			show(aPlayerBar.distTextWdg)
			if aPlayerBar.formSettings.showArrowButton then
				show(aPlayerBar.arrowIconWdg)
			end
		else
			hide(aPlayerBar.distTextWdg)
			if aPlayerBar.formSettings.showArrowButton then
				hide(aPlayerBar.arrowIconWdg)
			end
		end
	end
	if not anInfo.needShow then
		return
	end
	
	local zTxt = anInfo.deltaZ or 0
	if zTxt > 10 then
		zTxt = "+"
	elseif zTxt < -10 then
		zTxt = "-"
	else
		zTxt = "="
	end
	
	if aPlayerBar.optimizeInfo.currDeltaZ ~= zTxt then
		if aPlayerBar.formSettings.showDistanceButton then
			setText(aPlayerBar.zDistTextWdg, zTxt, "ColorWhite", "center", 18)
		end
		aPlayerBar.optimizeInfo.currDeltaZ = zTxt
	end
	
	if aPlayerBar.optimizeInfo.currDist ~= anInfo.dist then
		if aPlayerBar.formSettings.showDistanceButton then
			setText(aPlayerBar.distTextWdg, anInfo.dist, "ColorWhite", "center", 11)
		end
		
		aPlayerBar.optimizeInfo.currDist = anInfo.dist
	end
	
	if aPlayerBar.formSettings.showArrowButton and aPlayerBar.optimizeInfo.currAngle ~= anInfo.angle then
		SetArrowAngle(aPlayerBar.arrowIconWdg, anInfo.angle)
		aPlayerBar.optimizeInfo.currAngle = anInfo.angle
	end
	if anInfo.angle == nil then
		hide(aPlayerBar.arrowIconWdg)
	end
end

function PlayerTargetsHighlightChanged(anInfo, aPlayerBar)
	--local barColor = nil
	if anInfo then
	--	barColor = { r=1; g=0; b=0.6; a=1 }
		show(aPlayerBar.farBarBackgroundWdg)
	else
	--	barColor = { r=1; g=1; b=1; a=1 }
		hide(aPlayerBar.farBarBackgroundWdg)
	end
	aPlayerBar.highlight = anInfo
--[[
	if not compareColor(aPlayerBar.optimizeInfo.barBackgroundColor, barColor) then
		aPlayerBar.optimizeInfo.barBackgroundColor = barColor
		setBackgroundColor(aPlayerBar.barBackgroundWdg, barColor)
	end]]
end

local function FindBuffSlot(aPlayerBar, aBuffID, aBuffID2, aCnt, anArray)
	for i=1, aCnt do
		if anArray[i].buffID == aBuffID then
			return anArray[i], i
		end
	end
	return nil, nil
end

local function PlayerRemoveBuff(aBuffID, aPlayerBar, aCnt, anArray)
	local buffSlot, removeIndex = FindBuffSlot(aPlayerBar, aBuffID, nil, aCnt, anArray)
	if buffSlot then
		hide(buffSlot.buffWdg)
		if removeIndex ~= GetTableSize(anArray) then
			for i = removeIndex, aCnt do
				anArray[i] = anArray[i+1]
			end
			anArray[aCnt] = buffSlot
			for i = removeIndex, aCnt do
				move(anArray[i].buffWdg, 2+(i-1)*tonumber(aPlayerBar.formSettings.buffSize), 1)
			end
		end
		return true, buffSlot
	end
	return false, nil
end

local function PlayerRemoveBuffPositive(aBuffID, aPlayerBar)
	local wasRemoved, buffSlot = PlayerRemoveBuff(aBuffID, aPlayerBar, aPlayerBar.usedBuffSlotCnt, aPlayerBar.buffSlots)
	if wasRemoved then
		aPlayerBar.usedBuffSlotCnt = aPlayerBar.usedBuffSlotCnt - 1
		if aPlayerBar.usedBuffSlotCnt < 0 then
			aPlayerBar.usedBuffSlotCnt = 0
		end
	end
end

local function PlayerRemoveBuffNegative(aBuffID, aPlayerBar)
	local wasRemoved, buffSlot = PlayerRemoveBuff(aBuffID, aPlayerBar, aPlayerBar.usedBuffSlotNegCnt, aPlayerBar.buffSlotsNeg)
	if wasRemoved then
		aPlayerBar.usedBuffSlotNegCnt = math.max(aPlayerBar.usedBuffSlotNegCnt - 1, 0)
	end
end

local function GetTextSizeByBuffSize(aSize)
	return math.floor(aSize/1.3)
end

local function PlayerAddBuff(aBuffInfo, aPlayerBar, anArray, aCnt)
	if not aBuffInfo.texture then
		return false
	end
	local buffSlot = FindBuffSlot(aPlayerBar, aBuffInfo.id, aBuffInfo.buffId, aCnt, anArray)
	local res = false
	if not buffSlot then
		local newCnt = aCnt + 1
		if newCnt > GetTableSize(anArray) then
			return res
		end
		
		buffSlot = anArray[newCnt]
		buffSlot.buffID = aBuffInfo.id
		buffSlot.cleanableBuff = aBuffInfo.cleanableBuff
		buffSlot.buffWdg:Show(true)
		buffSlot.buffIcon:SetBackgroundTexture(aBuffInfo.texture)
		--buffSlot.buffIcon:SetFade(0.8)
		res = true
	end	
	if aBuffInfo.stackCount <= 1 then 
		hide(buffSlot.buffStackCnt)
	else
		show(buffSlot.buffStackCnt)
		setText(buffSlot.buffStackCnt, aBuffInfo.stackCount, nil, "right", GetTextSizeByBuffSize(tonumber(aPlayerBar.formSettings.buffSize)))
	end
	
	return res
end

local function PlayerAddBuffNegative(aBuffInfo, aPlayerBar)
	if PlayerAddBuff(aBuffInfo, aPlayerBar, aPlayerBar.buffSlotsNeg, aPlayerBar.usedBuffSlotNegCnt) then
		aPlayerBar.usedBuffSlotNegCnt = aPlayerBar.usedBuffSlotNegCnt + 1
	end
end

local function PlayerAddBuffPositive(aBuffInfo, aPlayerBar)
	if PlayerAddBuff(aBuffInfo, aPlayerBar, aPlayerBar.buffSlots, aPlayerBar.usedBuffSlotCnt) then
		aPlayerBar.usedBuffSlotCnt = aPlayerBar.usedBuffSlotCnt + 1
	end
end

function SetBaseInfoPlayerPanel(aPlayerBar, aPlayerInfo, anIsLeader, aFormSettings, aRelationType)
	aPlayerBar.isUsed = true
	aPlayerBar.playerID = aPlayerInfo.id
	aPlayerBar.uniqueID = aPlayerInfo.uniqueId
	aPlayerBar.formSettings = aFormSettings

	aPlayerBar.panelColorType = aRelationType
	
	aPlayerBar.usedBuffSlotCnt = 0
	for i = 1, GetTableSize(aPlayerBar.buffSlots) do 
		hide(aPlayerBar.buffSlots[i].buffWdg)
		aPlayerBar.buffSlots[i].buffID = nil
	end
	
	aPlayerBar.usedBuffSlotNegCnt = 0

	for i = 1, GetTableSize(aPlayerBar.buffSlotsNeg) do 
		hide(aPlayerBar.buffSlotsNeg[i].buffWdg)
		aPlayerBar.buffSlotsNeg[i].buffID = nil
	end
	--[[
	hide(aPlayerBar.importantBuff.buffWdg)
	aPlayerBar.importantBuff.buffID = nil
	]]
	hide(aPlayerBar.clearBarWdg)
	
	local barColor = { r = 0.1; g = 0.8; b = 0; a = 1.0 }
	local isPlayerExist = isExist(aPlayerInfo.id)
	
	if isPlayerExist and not aFormSettings.classColorModeButton then
		barColor = copyTable(m_relationColors[aPlayerBar.panelColorType])
	end

	hide(aPlayerBar.farBarBackgroundWdg)
	
	PlayerHPChanged(100, aPlayerBar)


	if common.CompareWString(aPlayerBar.optimizeInfo.name, aPlayerInfo.name)~=0 then
		aPlayerBar.optimizeInfo.name = aPlayerInfo.name
		--aPlayerBar.textWdg:SetVal("Name", aPlayerInfo.name)
		setText(aPlayerBar.textWdg, aPlayerInfo.name, "ColorYellow", "left", 11)
	end


	if not compareColor(aPlayerBar.optimizeInfo.barColor, barColor) then
		aPlayerBar.optimizeInfo.barColor = barColor
		setBackgroundColor(aPlayerBar.barWdg, barColor)
	end
	
	show(aPlayerBar.wdg)
end

function ResetPlayerPanelPosition(aPlayerBar, aX, aY, aFormSettings)
	local panelWidth = tonumber(aFormSettings.raidWidthText)
	local panelHeight = tonumber(aFormSettings.raidHeightText)
	local mod1 = aFormSettings.gorisontalModeButton and aY or aX
	local mod2 = aFormSettings.gorisontalModeButton and aX or aY
	local posX = mod1*panelWidth
	local posY = mod2*panelHeight+30
	
	if aPlayerBar.optimizeInfo.posX ~= posX or aPlayerBar.optimizeInfo.posY ~= posY then
		aPlayerBar.optimizeInfo.posX = posX
		aPlayerBar.optimizeInfo.posY = posY
		move(aPlayerBar.wdg, posX, posY)
	end
end

function CreatePlayerPanel(aParentPanel, aX, aY, aRaidMode, aFormSettings)
	setTemplateWidget(aParentPanel)
	local barColor = { r = 0.8; g = 0.8; b = 0; a = 1.0 }
	local panelWidth = tonumber(aFormSettings.raidWidthText)
	local panelHeight = tonumber(aFormSettings.raidHeightText)
	local buffSize = tonumber(aFormSettings.buffSize)
	local mod1 = aFormSettings.gorisontalModeButton and aY or aX
	local mod2 = aFormSettings.gorisontalModeButton and aX or aY
	local posX = mod1*panelWidth
	local posY = mod2*panelHeight+30

	local playerBar = {}

	playerBar.wdg = createWidget(aParentPanel, nil, "PlayerBar", nil, nil, panelWidth, panelHeight, posX, posY)
	playerBar.barWdg = getChild(playerBar.wdg, "HealthBar")
	playerBar.barBackgroundWdg = getChild(playerBar.wdg, "HealthBarBackground")
	playerBar.textWdg = getChild(playerBar.wdg, "PlayerNameText")
	playerBar.distTextWdg = getChild(playerBar.wdg, "PlayerDistText")
	playerBar.zDistTextWdg = getChild(playerBar.wdg, "ZDistText")
	playerBar.arrowIconWdg = getChild(playerBar.wdg, "ArrowIcon")
	playerBar.buffPanelWdg = getChild(playerBar.wdg, "BuffPanel")
	playerBar.buffPanelNegativeWdg = getChild(playerBar.wdg, "BuffPanelNegative")
	--playerBar.buffPanelImportantWdg = getChild(playerBar.wdg, "BuffPanelImportant")
	playerBar.farBarBackgroundWdg = getChild(playerBar.wdg, "FarBarBackground")
	playerBar.clearBarWdg = getChild(playerBar.wdg, "ClearBar")
	playerBar.optimizeInfo = {}
	playerBar.optimizeInfo.name = m_emptyWStr
	playerBar.optimizeInfo.shardName = m_emptyWStr
	playerBar.optimizeInfo.barColor = copyTable(barColor)
	playerBar.optimizeInfo.posX = posX
	playerBar.optimizeInfo.posY = posY

	playerBar.isUsed = false
	playerBar.wasVisible = false
	playerBar.panelColorType = FRIEND_PANEL
	
	local distWdgWidth = 25
	local zDistWdgWidth = 16
	local arrowWdgWidth = 18
	local nameStartPos = arrowWdgWidth+distWdgWidth+zDistWdgWidth+3
	align(playerBar.textWdg, WIDGET_ALIGN_LOW)
	move(playerBar.textWdg, arrowWdgWidth+distWdgWidth+zDistWdgWidth+3, -5)
	resize(playerBar.textWdg, panelWidth-nameStartPos)

	playerBar.textWdg:SetEllipsis(true)
		
	resize(playerBar.barBackgroundWdg, panelWidth, panelHeight)
	resize(playerBar.farBarBackgroundWdg, panelWidth, panelHeight)
	resize(playerBar.barWdg, panelWidth-2, panelHeight-2)
	resize(playerBar.clearBarWdg, panelWidth-2, panelHeight-2)
	resize(playerBar.buffPanelWdg, panelWidth, panelHeight)
	resize(playerBar.buffPanelNegativeWdg, panelWidth, panelHeight)
	
	move(playerBar.buffPanelNegativeWdg, nameStartPos)

	move(playerBar.barWdg, 1, 1)
	
	setBackgroundColor(playerBar.barWdg, barColor) 
	

	hide(playerBar.arrowIconWdg)
	align(playerBar.arrowIconWdg, WIDGET_ALIGN_LOW, WIDGET_ALIGN_LOW)
	move(playerBar.arrowIconWdg, 2, 6)
	resize(playerBar.arrowIconWdg, 16, 16)
	
	resize(playerBar.distTextWdg, distWdgWidth)
	align(playerBar.distTextWdg, WIDGET_ALIGN_LOW, WIDGET_ALIGN_LOW)
	move(playerBar.distTextWdg, arrowWdgWidth+zDistWdgWidth, 8)
	
	resize(playerBar.zDistTextWdg, zDistWdgWidth)
	align(playerBar.zDistTextWdg, WIDGET_ALIGN_LOW, WIDGET_ALIGN_LOW)
	move(playerBar.zDistTextWdg, arrowWdgWidth, 2)

	align(playerBar.farBarBackgroundWdg, WIDGET_ALIGN_LOW, WIDGET_ALIGN_HIGH)
	move(playerBar.farBarBackgroundWdg, 0, 0)
	hide(playerBar.farBarBackgroundWdg)
	
	barColor = { r = 0; g = 0; b = 0; a = 1.0 }
	setBackgroundColor(playerBar.clearBarWdg, barColor) 
	hide(playerBar.clearBarWdg)
	
	hide(playerBar.wdg)
	
	
	local buffSlotCnt = math.floor((panelWidth-nameStartPos) / buffSize)
	
	playerBar.buffSlots = {}
	playerBar.usedBuffSlotCnt = 0
	
	playerBar.buffSlotsNeg = {}
	playerBar.usedBuffSlotNegCnt = 0
	setTemplateWidget(m_template)
	
	for i = 1, buffSlotCnt do
		--CreateBuffSlot(playerBar.buffPanelWdg, buffSize, playerBar.buffSlots, i, WIDGET_ALIGN_LOW)
		CreateBuffSlot(playerBar.buffPanelNegativeWdg, buffSize, playerBar.buffSlotsNeg, i, WIDGET_ALIGN_LOW, WIDGET_ALIGN_HIGH)
	end
	--[[
	local importantSize = panelHeight-16
	resize(playerBar.buffPanelImportantWdg, panelWidth, panelHeight)
	playerBar.importantBuff = CreateBuffSlot(playerBar.buffPanelImportantWdg, importantSize, nil, 0, WIDGET_ALIGN_CENTER)
	move(playerBar.importantBuff.buffWdg, 0, 0)
	align(playerBar.buffPanelImportantWdg, WIDGET_ALIGN_CENTER, WIDGET_ALIGN_CENTER)
	hide(playerBar.importantBuff.buffWdg)
	]]
	playerBar.listenerHP = PlayerHPChanged
	playerBar.listenerDistance = PlayerDistanceChanged
	playerBar.listenerChangeBuff = PlayerAddBuffPositive
	playerBar.listenerChangeBuffNegative = PlayerAddBuffNegative
	playerBar.listenerRemoveBuff = PlayerRemoveBuffPositive
	playerBar.listenerRemoveBuffNegative = PlayerRemoveBuffNegative

	return playerBar
end

function CreateBuffSlot(aParent, aBuffSize, anResArray, anIndex, anAlign1, anAlign2)
	local buffSlot = {}
	buffSlot.buffWdg = createWidget(aParent, "mybuff"..anIndex, "BuffTemplate", anAlign1, anAlign2, aBuffSize, aBuffSize, 2+(anIndex-1)*aBuffSize, 1)
	buffSlot.buffIcon = getChild(buffSlot.buffWdg, "DotIcon")
	buffSlot.buffStackCnt = getChild(buffSlot.buffWdg, "DotStackText")
	align(buffSlot.buffStackCnt, WIDGET_ALIGN_HIGH, WIDGET_ALIGN_HIGH)
	resize(buffSlot.buffStackCnt, aBuffSize, GetTextSizeByBuffSize(aBuffSize))
	resize(buffSlot.buffIcon, aBuffSize, aBuffSize)
	show(buffSlot.buffIcon)
	if anResArray then
		table.insert(anResArray, buffSlot)	
	end
	return buffSlot
end



local m_locale = getLocale()
local m_modeBtn = nil
local m_lockBtn = nil
local m_targetModeName = nil

Global("ALL_TARGETS", 0)
Global("ENEMY_TARGETS", 1)
Global("FRIEND_TARGETS", 2)
Global("ENEMY_SHIPS_TARGETS", 3)
Global("FRIEND_SHIPS_TARGETS", 4)
Global("ENEMY_MOBS_TARGETS", 5)
Global("FRIEND_MOBS_TARGETS", 6)
Global("TARGETS_DISABLE", 7)




local m_targetSwitchArr = {}
m_targetSwitchArr[ALL_TARGETS] = m_locale["ALL_TARGETS"]
m_targetSwitchArr[ENEMY_TARGETS] = m_locale["ENEMY_TARGETS"]
m_targetSwitchArr[FRIEND_TARGETS] = m_locale["FRIEND_TARGETS"]
m_targetSwitchArr[ENEMY_SHIPS_TARGETS] = m_locale["ENEMY_SHIPS_TARGETS"]
m_targetSwitchArr[FRIEND_SHIPS_TARGETS] = m_locale["FRIEND_SHIPS_TARGETS"]
m_targetSwitchArr[ENEMY_MOBS_TARGETS] = m_locale["ENEMY_MOBS_TARGETS"]
m_targetSwitchArr[FRIEND_MOBS_TARGETS] = m_locale["FRIEND_MOBS_TARGETS"]
m_targetSwitchArr[TARGETS_DISABLE] = m_locale["TARGETS_DISABLE"]

function SwitchTargetsBtn(aNewTargetInd)
	m_targetModeName:SetVal("Name", m_targetSwitchArr[aNewTargetInd])
end

function TargetLockBtn(aTopPanelForm)
	local activeNum = m_lockBtn:GetVariant() == 1 and 0 or 1
	m_lockBtn:SetVariant(activeNum)
	m_modeBtn:SetVariant(activeNum)
	
	local wtTopPanel = getChild(aTopPanelForm, "TopTargeterPanel")
	DnD:Enable(wtTopPanel, activeNum==0)
end

function CreateTargeterPanel()
	setTemplateWidget(m_template)
	local targeterPanel = common.AddonCreateChildForm("TargetPanel")
	move(targeterPanel, 500, 380)
	local wtTopPanel = getChild(targeterPanel, "TopTargeterPanel")
	DnD:Init(targeterPanel, wtTopPanel, true, false)
	resize(wtTopPanel, 200, nil)
	
	local modePanel = getChild(wtTopPanel, "ModePanel")
	m_targetModeName = getChild(modePanel, "ModeNameTextView")
	m_lockBtn = getChild(wtTopPanel, "ButtonLocker")
	move(modePanel, 50, 3)
	resize(modePanel, 140, 20)
	m_modeBtn = getChild(modePanel, "GetModeBtn")
	
	hide(getChild(wtTopPanel, "ConfigButton"))
	hide(m_lockBtn)
	--TargetLockBtn(targeterPanel)
	hide(targeterPanel)
	return targeterPanel
end