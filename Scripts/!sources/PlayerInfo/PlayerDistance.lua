Global( "PlayerDistance", {} )


function PlayerDistance:Init(anID)
	self.playerID = anID
	self.unitParams = {}
	self.objParams1 = {}
	self.objParams2 = {}
	self.distance = 0
	self.lastDistance = -1
	self.lastAngle = -1
	self.someChanges = true
	self.SKIP_UPDATES_CNT = 5
	self.skipCnt = 0
	self.base = copyTable(PlayerBase)
	self.base:Init()
	
	self.eventFunc = self:GetEventFunc()

	self:RegisterEvent(anID)
end

function PlayerDistance:ClearLastValues()
	self.lastDistance = -1
	self.lastAngle = -1
	self.skipCnt = 0
	self.someChanges = true
end

function PlayerDistance:SubscribeTargetGui(aLitener)
	self:ClearLastValues()
	self.base:SubscribeTargetGui(self.playerID, aLitener, self.eventFunc)
	self:UpdateValueIfNeeded()
end

function PlayerDistance:UnsubscribeTargetGui()
	local info = { }
	info.needShow = false
	info.visibleChanged = true	
	local res = self.base.guiTargetListener and self.base.guiTargetListener.listenerDistance(info, self.base.guiTargetListener)
	
	self:ClearLastValues()
	self.base:UnsubscribeTargetGui()
end

function PlayerDistance:SubscribeRaidGui(aLitener)
	
end

function PlayerDistance:UnsubscribeRaidGui()
	
end

function PlayerDistance:TryDestroy()
	if self.base:CanDestroy() then
		self:UnRegisterEvent()
		return true
	end
	return false
end

function PlayerDistance:UpdateValueIfNeeded()
	if self.skipCnt == 0 then
		self.skipCnt = self.SKIP_UPDATES_CNT
	else
		self.skipCnt = self.skipCnt - 1
		return
	end

	
	local angle = 0
	local deltaZ = 0
	self.distance, deltaZ = getAstroDistanceToTarget( self.playerID )
	
	local profile = GetCurrentProfile()
	if self.distance ~= nil and profile.targeterFormSettings.showArrowButton then
		angle = getAstroAngleToTarget(self.playerID)
	end
	if self.someChanges then		
		local info = { }
		info.dist = self.distance
		info.angle = angle
		info.needShow = self.distance ~= nil
		info.visibleChanged = self.distance ~= self.lastDistance
		info.deltaZ = deltaZ
		
		self.lastDistance = info.dist
		self.lastAngle = info.angle
		self.someChanges = false
		local res = self.base.guiTargetListener and self.base.guiTargetListener.listenerDistance(info, self.base.guiTargetListener)
	end
end

function PlayerDistance:GetEventFunc()
	return function(aParams)
		self.someChanges = true
	end
end

function PlayerDistance:RegisterEvent(anID)
	self.unitParams.unitId = anID
	common.RegisterEventHandler(self.eventFunc, "EVENT_ASTRAL_UNIT_POS_CHANGED", self.unitParams)
	self.objParams1.id = anID
	common.RegisterEventHandler(self.eventFunc, "EVENT_TRANSPORT_POS_CHANGED", self.objParams1)
	if g_debugSubsrb then
		self.base:reg("dist")
		self.base:reg("dist")
	end
end

function PlayerDistance:UnRegisterEvent()
	common.UnRegisterEventHandler(self.eventFunc, "EVENT_ASTRAL_UNIT_POS_CHANGED", self.unitParams)
	common.UnRegisterEventHandler(self.eventFunc, "EVENT_TRANSPORT_POS_CHANGED", self.objParams1)
	if g_debugSubsrb then
		self.base:unreg("dist")
		self.base:unreg("dist")
	end
end