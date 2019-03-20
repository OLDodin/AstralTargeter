Global( "PlayerHP", {} )


function PlayerHP:Init(anID)
	self.playerID = anID
	self.unitParams = {}
	self.objParams = {}
	self.hp = 0
	self.lastHP = -1

	self.eventFunc = self:GetEventFunc()
	
	self.base = copyTable(PlayerBase)
	self.base:Init()
	
	self:RegisterEvent(anID)
end

function PlayerHP:ClearLastValues()
	self.lastHP = -1
end

function PlayerHP:SubscribeTargetGui(aLitener)
	self:ClearLastValues()
	self.base:SubscribeTargetGui(self.playerID, aLitener, self.eventFunc)
end

function PlayerHP:UnsubscribeTargetGui()
	self.base:UnsubscribeTargetGui()
end

function PlayerHP:SubscribeRaidGui(aLitener)
	self:ClearLastValues()
	self.base:SubscribeRaidGui(self.playerID, aLitener, self.eventFunc)
end

function PlayerHP:UnsubscribeRaidGui()
	self.base:UnsubscribeRaidGui()
end

function PlayerHP:TryDestroy()
	if self.base:CanDestroy() then
		self:UnRegisterEvent()
		return true
	end
	return false
end

function PlayerHP:UpdateValueIfNeeded()
	local res = nil
	local profile = GetCurrentProfile()
	
	if self.hp ~= self.lastHP then
		self.lastHP = self.hp
		res = self.base.guiTargetListener and self.base.guiTargetListener.listenerHP(self.hp, self.base.guiTargetListener)
	end
end

function PlayerHP:GetEventFunc()
	return function(aParams)
		local playerID = aParams.unitId or aParams.id
		if isExist(playerID) then
			local healthInfo = object.GetHealthInfo(playerID)
			self.hp = healthInfo and healthInfo.valuePercents
		end
	end
end

function PlayerHP:RegisterEvent(anID)
	self.unitParams.unitId = anID
	common.RegisterEventHandler(self.eventFunc, "EVENT_UNIT_HEALTH_CHANGED", self.unitParams)
	self.objParams.id = anID
	common.RegisterEventHandler(self.eventFunc, "EVENT_OBJECT_HEALTH_CHANGED", self.objParams)
	if g_debugSubsrb then
		self.base:reg("hp")
		self.base:reg("hp")
	end
end

function PlayerHP:UnRegisterEvent()
	common.UnRegisterEventHandler(self.eventFunc, "EVENT_UNIT_HEALTH_CHANGED", self.unitParams)
	common.UnRegisterEventHandler(self.eventFunc, "EVENT_OBJECT_HEALTH_CHANGED", self.objParams)
	if g_debugSubsrb then
		self.base:unreg("hp")
		self.base:unreg("hp")
	end
end