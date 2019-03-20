local m_currentProfile = nil

function LoadSettings()
	local profile = userMods.GetGlobalConfigSection("AT_Profile")
	
	
	local defaultProfile = {}
	

	local targeterFormSettings = profile or {}
	targeterFormSettings.classColorModeButton = false
	targeterFormSettings.gorisontalModeButton = false
	targeterFormSettings.highlightSelectedButton = true
	targeterFormSettings.separateBuffDebuff = false
	targeterFormSettings.twoColumnMode = false
	targeterFormSettings.raidWidthText = "200"
	targeterFormSettings.raidHeightText = "31"
	targeterFormSettings.buffSize = "15"
	targeterFormSettings.targetLimit = "18"
	targeterFormSettings.sortByName = true
	targeterFormSettings.sortByHP = true
	targeterFormSettings.sortByClass = true
	targeterFormSettings.showArrowButton = true
	targeterFormSettings.showDistanceButton = true
	if not profile then
		targeterFormSettings.lastTargetType = ALL_TARGETS
		targeterFormSettings.lastTargetWasActive = true
	end
	
		
	defaultProfile.targeterFormSettings = targeterFormSettings
	
	m_currentProfile = defaultProfile

	SaveProfile(defaultProfile)
end

function GetCurrentProfile()
	return m_currentProfile
end

function SaveProfile(aProfile)
	userMods.SetGlobalConfigSection("AT_Profile", aProfile.targeterFormSettings)
end