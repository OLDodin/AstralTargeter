local m_players = {}

local function CreatePlayerSubInfo(anID, aSubClass)
	local playerSubClassInfo = copyTable(aSubClass)
	playerSubClassInfo:Init(anID)

	return playerSubClassInfo
end

local function FabricMakePlayerInfo(anID, aListener, anIsRaidInfo)
	if not isExist(anID) then
		return
	end
	local player = m_players[anID] or {}

	if not player.hp then
		player.hp = CreatePlayerSubInfo(anID, PlayerHP)	
	end
	player.hp:SubscribeTargetGui(aListener)

	if not player.distance then
		player.distance = CreatePlayerSubInfo(anID, PlayerDistance)
	end
	player.distance:SubscribeTargetGui(aListener)

	if not player.buffs then
		player.buffs = CreatePlayerSubInfo(anID, PlayerBuffs)
	end
	player.buffs:SubscribeTargetGui(aListener)
	
	m_players[anID] = player
end


function FabricMakeTargetPlayerInfo(anID, aListener)
	FabricMakePlayerInfo(anID, aListener, false)
end

function FabricClearAll()
	UnsubscribeTargetListener()

	FabricDestroyUnused()
end

function UnsubscribeTargetListener(anID)
	for playerID, player in pairs(m_players) do
		if not anID or playerID == anID then
			for _, playerInfo in pairs(player) do
				playerInfo:UnsubscribeTargetGui()
			end
		end
	end
end

function FabricDestroyUnused()
	for playerID, player in pairs(m_players) do
		local playerObjAlive = false
		
		for playerInfoIndex, playerInfo in pairs(player) do
			if playerInfo:TryDestroy() then
				player[playerInfoIndex] = nil
			else
				playerObjAlive = true
			end
		end
		
		if not playerObjAlive then 
			m_players[playerID] = nil
		end
		
	end
end

function UpdateFabric()
	for playerID, player in pairs(m_players) do
		if isExist(playerID) then
			for _, playerInfo in pairs(player) do
				playerInfo:UpdateValueIfNeeded()
			end
		end
	end
	
	FabicLogInfo()
end

local tick = 0
function FabicLogInfo()
	if not g_debugSubsrb then
		return
	end
	if tick == 200 then 
		LogInfo("FabicLogInfo begin")
		for n, v in pairs(g_regCnt) do
			LogInfo("FabicLogInfo n = ", n, "  cnt = ", v, "  s = ", GetTableSize(m_players))
		end
		LogInfo("FabicLogInfo end")	
		tick = 0
	end
	tick = tick + 1
end

function BuffsChanged(aParams)
	for objId, buffs in pairs( aParams.objects ) do
		if m_players[objId] then
			for buffId, active in pairs( buffs ) do
				if active then
					m_players[objId].buffs.changeEventFunc(buffId)
				end
			end
		end
	end 
end

function UnitRelativityDirPosChanged(aParams)
	local shipID = unit.GetTransport( avatar.GetId() )
	if not shipID then return end
	if shipID ~= aParams.unitId and shipID ~= aParams.id then
		return
	end
	for playerID, player in pairs(m_players) do
		if isExist(playerID) then
			player.distance.eventFunc(aParams)
		end
	end
end
