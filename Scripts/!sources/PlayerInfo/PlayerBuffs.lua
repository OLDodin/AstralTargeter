Global( "PlayerBuffs", {} )


function PlayerBuffs:Init(anID)
	self.playerID = anID
	self.unitParams = {}
	self.ignoreTargeterBuffsID = {}

	self.updateCnt = 0
	
	self.readAllTargetEventFunc = self:GetReadAllTargetEventFunc()

	self.delEventFunc = self:GetDelEventFunc()
	self.addEventFunc = self:GetAddEventFunc()
	self.changeEventFunc = self:GetChangedEventFunc()

	self.base = copyTable(PlayerBase)
	self.base:Init()

	self:RegisterEvent(anID)
end

function PlayerBuffs:ClearLastValues()
	self.updateCnt = 0

	self.ignoreTargeterBuffsID = {}
end

function PlayerBuffs:SubscribeTargetGui(aLitener)
	self:ClearLastValues()
	self.base:SubscribeTargetGui(self.playerID, aLitener, self.readAllTargetEventFunc)
end

function PlayerBuffs:UnsubscribeTargetGui()
	self.base:UnsubscribeTargetGui()
end

function PlayerBuffs:SubscribeRaidGui(aLitener)
end

function PlayerBuffs:UnsubscribeRaidGui()
end

function PlayerBuffs:SubscribeAboveHeadGui(aLitener)
end

function PlayerBuffs:UnsubscribeAboveHeadGui()
end

function PlayerBuffs:SubscribeBuffPlateGui(aLiteners)
end

function PlayerBuffs:UnsubscribeBuffPlateGui()
end


function PlayerBuffs:TryDestroy()
	if self.base:CanDestroy() then
		self:UnRegisterEvent()
		return true
	end
	return false
end

function PlayerBuffs:UpdateValueIfNeeded()
	self.updateCnt = self.updateCnt + 1
	if self.updateCnt == 3000 then
		self:ClearLastValues()
	end
end

function PlayerBuffs:CallListenerIfNeeded(aBuffID, aListener, aCondition, aRaidType, anIgnoreBuffsList)
	if aListener and not anIgnoreBuffsList[aBuffID] then
		local buffInfo = aBuffID and object.GetBuffInfo(aBuffID)
		if buffInfo and buffInfo.name then
			local searchResult, findedObj = aCondition:Check(buffInfo)
			if searchResult then
				if aRaidType then
					if buffInfo.isPositive then
						aListener.listenerChangeBuff(buffInfo, aListener)
					else
						aListener.listenerChangeBuffNegative(buffInfo, aListener)
					end
				else
					aListener.listenerChangeBuffNegative(buffInfo, aListener, findedObj and findedObj.ind or nil)
				end
			else
				anIgnoreBuffsList[aBuffID] = true
			end
		end
	end
end

function PlayerBuffs:GetReadAllEventFunc(aParams, aListener, aCondition, aRaidType, anIgnoreBuffsList)
	if aListener and aCondition then
		--local unitBuffs = object.GetBuffs(aParams.unitId)
		local unitBuffs = object.GetBuffsWithProperties(aParams.unitId, true, true)
		for i, buffID in pairs(unitBuffs) do
			self:CallListenerIfNeeded(buffID, aListener, aCondition, aRaidType, anIgnoreBuffsList)
		end
		unitBuffs = object.GetBuffsWithProperties(aParams.unitId, false, true)
		for i, buffID in pairs(unitBuffs) do
			self:CallListenerIfNeeded(buffID, aListener, aCondition, aRaidType, anIgnoreBuffsList)
		end
	end
end


function PlayerBuffs:GetReadAllTargetEventFunc()
	return function(aParams)
		local profile = GetCurrentProfile()
		local asRaid = profile.targeterFormSettings.separateBuffDebuff
		self:GetReadAllEventFunc(aParams, self.base.guiTargetListener, GetBuffConditionForTargeter(), asRaid, self.ignoreTargeterBuffsID)
	end
end

function PlayerBuffs:GetAddEventFunc()
	return function(aParams)
		local profile = GetCurrentProfile()
		local asRaid = profile.targeterFormSettings.separateBuffDebuff
		
		self:CallListenerIfNeeded(aParams.buffId, self.base.guiTargetListener, GetBuffConditionForTargeter(), asRaid, self.ignoreTargeterBuffsID)
	end
end

function PlayerBuffs:GetDelEventFunc()
	return function(aParams)
		local profile = GetCurrentProfile()
		local asRaid = profile.targeterFormSettings.separateBuffDebuff
		if self.base.guiTargetListener then
			if asRaid then
				self.base.guiTargetListener.listenerRemoveBuff(aParams.buffId, self.base.guiTargetListener)
			end
			self.base.guiTargetListener.listenerRemoveBuffNegative(aParams.buffId, self.base.guiTargetListener)
		end
	end
end

function PlayerBuffs:GetChangedEventFunc()
	return function(aParams)
		local profile = GetCurrentProfile()
		local asRaid = profile.targeterFormSettings.separateBuffDebuff
		
		self:CallListenerIfNeeded(aParams, self.base.guiTargetListener, GetBuffConditionForTargeter(), asRaid, self.ignoreTargeterBuffsID)
	end
end

function PlayerBuffs:RegisterEvent(anID)
	self.unitParams.objectId = anID

	common.RegisterEventHandler(self.addEventFunc, 'EVENT_OBJECT_BUFF_ADDED', self.unitParams)
	common.RegisterEventHandler(self.delEventFunc, 'EVENT_OBJECT_BUFF_REMOVED', self.unitParams)
	if g_debugSubsrb then
		self.base:reg("buff")
		self.base:reg("buff")
	end
end

function PlayerBuffs:UnRegisterEvent()
	common.UnRegisterEventHandler(self.addEventFunc, 'EVENT_OBJECT_BUFF_ADDED', self.unitParams)
	common.UnRegisterEventHandler(self.delEventFunc, 'EVENT_OBJECT_BUFF_REMOVED', self.unitParams)
	
	if g_debugSubsrb then
		self.base:unreg("buff")
		self.base:unreg("buff")
	end
end