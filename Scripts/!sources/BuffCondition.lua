Global( "BuffCondition", {} )



function BuffCondition:Init(aSettings)
	self.settings = aSettings
end

function BuffCondition:Check(aBuffInfo)
	return aBuffInfo.isNeedVisualize	
end


local m_targeterCondition = nil


function InitBuffConditionMgr()
	local profile = GetCurrentProfile()

	m_targeterCondition = copyTable(BuffCondition)
	m_targeterCondition:Init(profile.targeterFormSettings.raidBuffs)

end

function GetBuffConditionForRaid()
	return m_raidCondition
end

function GetBuffConditionForTargeter()
	return m_targeterCondition
end

function GetBuffConditionForBuffPlate(anPlateIndex)
	return m_buffPlateConditionArr[anPlateIndex]
end

function GetBuffConditionForAboveHead()
	return m_aboveHeadCondition
end