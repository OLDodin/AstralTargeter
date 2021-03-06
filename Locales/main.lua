Global("Locales", {})

function getLocale()
	return Locales[common.GetLocalization()] or Locales["eng"]
end

--------------------------------------------------------------------------------
-- Russian
--------------------------------------------------------------------------------

Locales["rus"]={}
Locales["rus"]["raidButton"]=				"��������� �����"
Locales["rus"]["targeterButton"]=			"��������� ���������"
Locales["rus"]["targeterButton"]=			"��������� ���������"
Locales["rus"]["buffsButton"]=				"��������� ������"
Locales["rus"]["bindButton"]=				"��������� ��������"
Locales["rus"]["okButton"]=					"OK"
Locales["rus"]["useRaidSubSystem"]=			"�������� �������� ����������"
Locales["rus"]["useTargeterSubSystem"]=		"�������� ��������"
Locales["rus"]["useBuffMngSubSystem"]=		"�������� ���� ��������"
Locales["rus"]["useBindSubSystem"]=			"�������� ������� (�� �������� � ���)"
Locales["rus"]["raidBuffsButton"]=			"������������ �����"
Locales["rus"]["raidWidthText"]=			"������ ������"
Locales["rus"]["raidHeightText"]=			"������ ������"
Locales["rus"]["raidSettingsFormHeader"]=	"��������� �����"
Locales["rus"]["targeterSettingsFormHeader"]="��������� ���������"
Locales["rus"]["targeterBuffsButton"]=		"������������ �����"
Locales["rus"]["myTargetsButton"]=			"���� � �������:"
Locales["rus"]["raidBuffSettingsFormHeader"]="����� �����"
Locales["rus"]["addRaidBuffButton"]=		"��������: "
Locales["rus"]["raidBuffsList"]=			"��������� �����:"
Locales["rus"]["addTargeterBuffButton"]=	"��������: "
Locales["rus"]["addTargetButton"]=			"��������: "
Locales["rus"]["buffSizeText"]=				"������ �����: "
Locales["rus"]["showImportantButton"]=		"���������� ������: "
Locales["rus"]["checkControlsButton"]=		"���������� ��������: "
Locales["rus"]["checkMovementsButton"]=		"���������� ����������: "
Locales["rus"]["hideUnselectableButton"]=	"�������� ����������� �����: "
Locales["rus"]["buffsFixInsidePanelButton"]="������������� ����� ������ ������:"
Locales["rus"]["castByMe"]=					"���"
Locales["rus"]["flipBuffsButton"]=			"����� ������ ������:"
Locales["rus"]["aboveHeadButton"]=			"��� ����� ��� ������� ������:"
Locales["rus"]["isEnemyButton"]=			"     � ����� ��� ������� ������ ��� ������:"
Locales["rus"]["isSpell"]=					"������"
Locales["rus"]["bindSettingsFormHeader"]=	"����� ������"
Locales["rus"]["bindForRaidHeader"]=		"����� ��� �����"
Locales["rus"]["bindForTargetHeader"]=		"����� ��� ���������"
Locales["rus"]["raidBindSimpleButton"]=		"������� ����"
Locales["rus"]["raidBindShiftButton"]=		"Shift+����"
Locales["rus"]["raidBindAltButton"]=		"Alt+����"
Locales["rus"]["raidBindCtrlButton"]=		"Ctrl+����"
Locales["rus"]["targetBindSimpleButton"]=	"������� ����"
Locales["rus"]["targetBindShiftButton"]=	"Shift+����"
Locales["rus"]["targetBindAltButton"]=		"Alt+����"
Locales["rus"]["targetBindCtrlButton"]=		"Ctrl+����"
Locales["rus"]["separateBuffDebuff"]=		"�������� ���� � ������"
Locales["rus"]["twoColumnMode"]=			"�� ��� � ��� � ��������� �������"
Locales["rus"]["checkFriendCleanableButton"]="��������� ����� �� ���������:"
Locales["rus"]["colorDebuffButton"]=		"     � ������������ ��������� �������:"
Locales["rus"]["sortByName"]=				"����������� �� �����"
Locales["rus"]["sortByHP"]=					"����������� �� ��"
Locales["rus"]["sortByClass"]=				"����������� �� �������"
Locales["rus"]["sortByDead"]=				"����������� �������"
Locales["rus"]["targetLimitText"]=				"����� �����  (1-30)"

Locales["rus"]["ALL_TARGETS"]=				"���"
Locales["rus"]["ENEMY_TARGETS"]=			"����������"
Locales["rus"]["FRIEND_TARGETS"]=			"�������������"
Locales["rus"]["ENEMY_PLAYERS_TARGETS"]=	"������ ����������"
Locales["rus"]["FRIEND_PLAYERS_TARGETS"]=	"������ �������������"
Locales["rus"]["NEITRAL_PLAYERS_TARGETS"]=	"������ �����������"
Locales["rus"]["ENEMY_MOBS_TARGETS"]=		"������� ����������"
Locales["rus"]["FRIEND_MOBS_TARGETS"]=		"������� �������������"
Locales["rus"]["NEITRAL_MOBS_TARGETS"]=		"������� �����������"
Locales["rus"]["ENEMY_PETS_TARGETS"]=		"���� ����������"
Locales["rus"]["FRIEND_PETS_TARGETS"]=		"���� �������������"
Locales["rus"]["NOT_FRIENDS_TARGETS"]=		"�����+�����������"
Locales["rus"]["NOT_FRIENDS_PLAYERS_TARGETS"]="������ �����+�����������"
Locales["rus"]["MY_SETTINGS_TARGETS"]=		"��� ����"
Locales["rus"]["ENEMY_SHIPS_TARGETS"]=		"������� ����������"
Locales["rus"]["FRIEND_SHIPS_TARGETS"]=		"������� �������������"
Locales["rus"]["TARGETS_DISABLE"]=			"���������"

Locales["rus"]["LEFT_CLICK"]=				"�����"
Locales["rus"]["RIGHT_CLICK"]=				"������"

Locales["rus"]["DISABLE_CLICK"]=			"���������"
Locales["rus"]["SELECT_CLICK"]=				"��������"
Locales["rus"]["MENU_CLICK"]=				"����"
Locales["rus"]["TARGET_CLICK"]=				"���� ����"
Locales["rus"]["RESSURECT_CLICK"]=			"����������"
Locales["rus"]["AUTOCAST_CLICK"]=			"������"

Locales["rus"]["mobsButton"]=				"����"
Locales["rus"]["controlsButton"]=			"��������"
Locales["rus"]["debuffsButton"]=			"�������"
Locales["rus"]["barsButton"]=				"������"
Locales["rus"]["saveButton"]=				"���������"
Locales["rus"]["configHeader"]		=		"���������"
Locales["rus"]["leftClick"]			=		"����� ������"
Locales["rus"]["rightClick"]		=		"������ ������"
Locales["rus"]["testSpellNameText"]	=		"�������� ����������"
Locales["rus"]["ressurectNameText"]	=		"�����������"
Locales["rus"]["configMobsHeader"]	=		"������������� ��������"
Locales["rus"]["configDebuffsHeader"]	=	"������������� �������"
Locales["rus"]["configControlsHeader"]	=	"������������� ��������"
Locales["rus"]["configBuffsHeader"]	=		"������ ������ ��� �������"
Locales["rus"]["configBarsHeader"]	=		"��������� �������"
Locales["rus"]["widthBuffCntText"]	=		"���-�� ������ � ������"
Locales["rus"]["heightBuffCntText"]	=		"����� ����� ������"
Locales["rus"]["heightGroupText"]	=		"������ ������"
Locales["rus"]["widthGroupText"]	=		"���������� �����"
Locales["rus"]["sizeBuffGroupText"]	=		"������ �����"
Locales["rus"]["buffOnMe"]	=				"��� ����� �� ���:"
Locales["rus"]["buffOnTarget"]	=			"��� ����� �� ���� ����:"
Locales["rus"]["configBuffsHeader2"]	=	"������������� ����� �� ����"
Locales["rus"]["configGroupBuffsHeader"]=	"�������� ��������� ������:"
Locales["rus"]["editGroupBuffsButton"]=		"�������� ������:"
Locales["rus"]["saveGroupBuffsButton"]=		"���������"
Locales["rus"]["addDebuffButton"]=			"��������: "
Locales["rus"]["addMobsButton"]=			"��������: "
Locales["rus"]["addControlButton"]=			"��������: "
Locales["rus"]["addGroupBuffsButton"]=		"�������� ������: "
Locales["rus"]["addBuffsButton"]=			"��������: "
Locales["rus"]["priorButton"]=				"������������ �����"
Locales["rus"]["autoDebuffModeButton"]=		"���������� ����� �� ���������:"
Locales["rus"]["autoDebuffModeButtonUnk"]=	"��������� ����� �� ���������:"
Locales["rus"]["woundsShowButton"]=			"���������� ��������� ���:"
Locales["rus"]["ignoreSysBuffs"]=			"������������ ��������� ����"
Locales["rus"]["checkEnemyCleanable"]=		"��������� ����� �� ����������:"
Locales["rus"]["checkEnemyCleanableUnk"]=	"��������� ����� �� ����������:"
Locales["rus"]["shiftButton"]=				"Shift"
Locales["rus"]["ctrlButton"]=				"Ctrl"
Locales["rus"]["altButton"]=				"Alt"
Locales["rus"]["enemyButton"]=				"����"
Locales["rus"]["targetButton"]=				"���������� ����"
Locales["rus"]["lastTargetButton"]=			"���������� ���������� ����"
Locales["rus"]["classColorModeButton"]=		"����� ������"
Locales["rus"]["firstShowButton"]=			"�������� ������ ������"
Locales["rus"]["selectModeButton"]  =		"������ �������� � ����"
Locales["rus"]["buffsFixButton"]  =			"��������� �� ������:"
Locales["rus"]["showManaButton"]=			"���������� ����/�������"
Locales["rus"]["showShieldButton"]=			"���������� ����"
Locales["rus"]["showServerNameButton"]=		"���������� ������"
Locales["rus"]["distanceText"]=				"���������� ������������"
Locales["rus"]["highlightSelectedButton"]=	"������� ����"
Locales["rus"]["showStandartRaidButton"]=	"���������� ��������� �����/������"
Locales["rus"]["showClassIconButton"]=		"���������� ������ ������"
Locales["rus"]["showDistanceButton"]=		"���������� ���������"
Locales["rus"]["showProcentButton"]=		"���������� �������� ��������"
Locales["rus"]["showArrowButton"]=			"���������� ���������"
Locales["rus"]["updateTimeBuffsButton"]=	"����� ����������(���)"

Locales["rus"]["configProfilesHeader"]=		"���������� ���������: "
--Locales["rus"]["configProfilesCurrent"]=	"������� �������: "
Locales["rus"]["saveAsProfileButton"]=		"��������� ������� ������� ���: "
Locales["rus"]["profilesButton"]=			"�������"	

Locales["rus"]["inspectButton"]=			"���������"
Locales["rus"]["kickMenuButton"]=			"���������"
Locales["rus"]["closeMenuButton"]=			"�������"
Locales["rus"]["leaveMenuButton"]=			"�������� ������"
Locales["rus"]["raidLeaveMenuButton"]=		"�������� �����"
Locales["rus"]["leaderMenuButton"]=			"��������� �������"

Locales["rus"]["freeLootMenuButton"]=		"�����: ���� ��� �����"
Locales["rus"]["masterLootMenuButton"]=		"�����: ���������� ������"
Locales["rus"]["groupLootMenuButton"]=		"�����: ��������� ���"
Locales["rus"]["junkLootMenuButton"]=		"�������� �����: �����"
Locales["rus"]["goodsLootMenuButton"]=		"�������� �����: �����"
Locales["rus"]["commonLootMenuButton"]=		"�������� �����: �������"
Locales["rus"]["uncommonLootMenuButton"]=	"�������� �����: �����"
Locales["rus"]["rareLootMenuButton"]=		"�������� �����: ����������"
Locales["rus"]["epicLootMenuButton"]=		"�������� �����: ���������"
Locales["rus"]["legendaryLootMenuButton"]=	"�������� �����: ���������"
Locales["rus"]["relicLootMenuButton"]=		"�������� �����: ��������"

Locales["rus"]["disbandMenuButton"]=		"����������"
Locales["rus"]["inviteMenuButton"]=			"����������"
Locales["rus"]["createRaidMenuButton"]=		"������� ����"
Locales["rus"]["createSmallRaidMenuButton"]="������� ����� ����"
Locales["rus"]["addLeaderHelperMenuButton"]="��������� ����������"
Locales["rus"]["addMasterLootMenuButton"]=	"��������� ���. �� ������"
Locales["rus"]["deleteLeaderHelperMenuButton"]=	"������ ���������"
Locales["rus"]["deleteMasterLootMenuButton"]=	"������ ���. �� ������"
Locales["rus"]["moveMenuButton"]=			"�����������"
Locales["rus"]["whisperMenuButton"]=		"��������� ���������"

Locales["rus"]["configGroupBuffsId"]=		"ID"
Locales["rus"]["configGroupBuffsName"]=		"��������"
Locales["rus"]["configGroupBuffsTime"]=		"����� ������"
Locales["rus"]["configGroupBuffsCD"]  =		"��"
Locales["rus"]["configGroupBuffsBuff"] =	"����"


Locales["rus"]["allShop"]=			{"�������� ���������������", "�������� ���� ����. �����", "�������� ����� ����. �����", "�������� �������������", "�������� ����������", "�������� ������� �����","�������� ���������", 
										"�������� ����������� �����","�������� ���������� �����","�������� ������������� �����","�������� ���������� �����",
										"�������� ���������������", "�������� ���� ����. �����", "�������� ����� ����. �����", "�������� �������������", "�������� ����������", "�������� ������� �����","�������� ���������", 
										"�������� ����������� �����","�������� ���������� �����","�������� ������������� �����","�������� ���������� �����",
										"������ �������� ���������������", "������ �������� ���� ����. �����", "������ �������� ����� ����. �����", "������ �������� �������������", "������ �������� ����������", "������ �������� ������� �����","������ �������� ���������", "������ �������� ����������� �����","������ �������� ���������� �����","������ �������� ������������� �����","������ �������� ���������� �����",
										"�������� ���������", "�������� ����", "�������� �������������","�������� ���������","�������� ������������","�������� ������������","�������� �����������������",
										"�������� ���������� ������","�������� ��������� ������","�������� ������������ ������","�������� ��������� ������",
										"�������� ���������", "�������� ����", "�������� �������������","�������� ���������","�������� ������������","�������� ������������","�������� �����������������",
										"�������� ���������� ������","�������� ��������� ������","�������� ������������ ������","�������� ��������� ������",
										"������ �������� ���������", "������ �������� ����", "������ �������� �������������","������ �������� ���������","������ �������� ������������","������ �������� ������������","������ �������� �����������������", "������ �������� ���������� ������","������ �������� ��������� ������","������ �������� ������������ ������","������ �������� ��������� ������",
										"������������ �������� ����������", "������������ �������� �������������", "������������ �������� ���������", 
										"�������� ����������� �����", "�������� ���������� �����", "�������� ������������� �����", "�������� ���������� �����", 
										"������� ��������", "����", "���������", "���������"}


Locales["rus"]["defaultRessurectNames"]=	{ 	{ name = "��� �������" },
												{ name = "����������� �����" },
												{ name = "�����������" }
											}
Locales["rus"]["loadedMessage"] =			"������� ��������: "
Locales["rus"]["savedMessage"] =			"������� ��������: "
Locales["rus"]["savedAddMessage"] =			". ���������� ��� ������� ��� "
Locales["rus"]["groupSavedMessage"] =		"��������� ������ ���������."	
Locales["rus"]["build1Name"] =				"����� �������� 1"	
Locales["rus"]["build2Name"] =				"����� �������� 2"	
	
Locales["rus"]["gorisontalModeButton"] =	"�������������� �����: "				
Locales["rus"]["twoxtwoModeButton"] =		"����� 2�2: "								

--------------------------------------------------------------------------------
-- English
--------------------------------------------------------------------------------

		
Locales["eng"]={}
Locales["eng"]["raidButton"]=				"Raid settings"
Locales["eng"]["targeterButton"]=			"Targeter settings"
Locales["eng"]["buffsButton"]=				"Buff settings"
Locales["eng"]["bindButton"]=				"Macros settings"
Locales["eng"]["okButton"]=					"OK"
Locales["eng"]["useRaidSubSystem"]=			"Enable raid subsystem"
Locales["eng"]["useTargeterSubSystem"]=		"Enable targeter subsystem"
Locales["eng"]["useBuffMngSubSystem"]=		"Enable buff plates subsystem"
Locales["eng"]["useBindSubSystem"]=			"Enable macros subsystem"
Locales["eng"]["raidBuffsButton"]=			"Displayed buffs"
Locales["eng"]["raidWidthText"]=			"Panel width"
Locales["eng"]["raidHeightText"]=			"Panel height"
Locales["eng"]["raidSettingsFormHeader"]=	"Raid settings"
Locales["eng"]["targeterSettingsFormHeader"]="Targeter settings"
Locales["eng"]["targeterBuffsButton"]=		"Displayed buffs"
Locales["eng"]["myTargetsButton"]=			"Targets with names:"
Locales["eng"]["raidBuffSettingsFormHeader"]="Raid buffs"
Locales["eng"]["addRaidBuffButton"]=		"Add: "
Locales["eng"]["raidBuffsList"]=			"Specified buffs:"
Locales["eng"]["addTargeterBuffButton"]=	"Add: "
Locales["eng"]["addTargetButton"]=			"Add: "
Locales["eng"]["buffSizeText"]=				"Buff icon size: "
Locales["eng"]["showImportantButton"]=		"Show special: "
Locales["eng"]["checkControlsButton"]=		"Show controls: "
Locales["eng"]["checkMovementsButton"]=		"Show movement impairing: "
Locales["eng"]["hideUnselectableButton"]=	"Hide unselectable mobs: "
Locales["eng"]["buffsFixInsidePanelButton"]="Lock buffs pos inside the panel:"
Locales["eng"]["castByMe"]=					"My"
Locales["eng"]["flipBuffsButton"]=			"Buffs from right to left:"
Locales["eng"]["aboveHeadButton"]=			"This buffs over the player's head:"
Locales["eng"]["isEnemyButton"]=			"     � Buffs above the head only for enemies:"
Locales["eng"]["isSpell"]=					"Spell"
Locales["eng"]["bindSettingsFormHeader"]=	"Binds"
Locales["eng"]["bindForRaidHeader"]=		"Binds for raid"
Locales["eng"]["bindForTargetHeader"]=		"Binds for targeter"
Locales["eng"]["raidBindSimpleButton"]=		"Simple click"
Locales["eng"]["raidBindShiftButton"]=		"Shift+click"
Locales["eng"]["raidBindAltButton"]=		"Alt+click"
Locales["eng"]["raidBindCtrlButton"]=		"Ctrl+click"
Locales["eng"]["targetBindSimpleButton"]=	"Simple click"
Locales["eng"]["targetBindShiftButton"]=	"Shift+click"
Locales["eng"]["targetBindAltButton"]=		"Alt+click"
Locales["eng"]["targetBindCtrlButton"]=		"Ctrl+click"
Locales["eng"]["separateBuffDebuff"]=		"Separate buff/debuff"
Locales["eng"]["twoColumnMode"]=			"Two column mode"
Locales["eng"]["checkFriendCleanableButton"]="Dispelling buffs on friends:"
Locales["eng"]["colorDebuffButton"]=		"     � Highlight cleanable players:"
Locales["eng"]["sortByName"]=				"Sort by name"
Locales["eng"]["sortByHP"]=					"Sort by HP"
Locales["eng"]["sortByClass"]=				"Sort by class"
Locales["eng"]["sortByDead"]=				"Sort by dead"
Locales["eng"]["targetLimitText"]=			"Number of targets (1-30)"

Locales["eng"]["ALL_TARGETS"]=				"All"
Locales["eng"]["ENEMY_TARGETS"]=			"Enemy"
Locales["eng"]["FRIEND_TARGETS"]=			"Friends"
Locales["eng"]["ENEMY_PLAYERS_TARGETS"]=	"Enemy players"
Locales["eng"]["FRIEND_PLAYERS_TARGETS"]=	"Friend players"
Locales["eng"]["NEITRAL_PLAYERS_TARGETS"]=	"Neitral players"
Locales["eng"]["ENEMY_MOBS_TARGETS"]=		"Enemy mobs"
Locales["eng"]["FRIEND_MOBS_TARGETS"]=		"Friend mobs"
Locales["eng"]["NEITRAL_MOBS_TARGETS"]=		"Neitral mobs"
Locales["eng"]["ENEMY_PETS_TARGETS"]=		"Enemy pets"
Locales["eng"]["FRIEND_PETS_TARGETS"]=		"Friend pets"
Locales["eng"]["MY_SETTINGS_TARGETS"]=		"My targets"
Locales["eng"]["TARGETS_DISABLE"]=			"DISABLED"

Locales["eng"]["LEFT_CLICK"]=				"Left"
Locales["eng"]["RIGHT_CLICK"]=				"Right"

Locales["eng"]["DISABLE_CLICK"]=			"Disable"
Locales["eng"]["SELECT_CLICK"]=				"Select"
Locales["eng"]["MENU_CLICK"]=				"Menu"
Locales["eng"]["TARGET_CLICK"]=				"Target"
Locales["eng"]["RESSURECT_CLICK"]=			"Ressurect"
Locales["eng"]["AUTOCAST_CLICK"]=			"None"

Locales["eng"]["mobsButton"]=				"Units"
Locales["eng"]["controlsButton"]=			"Controls"
Locales["eng"]["debuffsButton"]=			"Debuffs"
Locales["eng"]["barsButton"]=				"Panels"
Locales["eng"]["saveButton"]=				"Save"
Locales["eng"]["configHeader"]		=		"Settings"
Locales["eng"]["leftClick"]			=		"Left Click"
Locales["eng"]["rightClick"]		=		"Right Click"
Locales["eng"]["testSpellNameText"]	=		"Test Spell"
Locales["eng"]["ressurectNameText"]	=		"Ressurect Spell"
Locales["eng"]["configMobsHeader"]	=		"Detected units"
Locales["eng"]["configDebuffsHeader"]	=	"Detected debuffs"
Locales["eng"]["configControlsHeader"]	=	"Detected controls"
Locales["eng"]["configBuffsHeader"]	=		"Buff groups for panels"
Locales["eng"]["configBarsHeader"]	=		"Panel settings"
Locales["eng"]["widthBuffCntText"]	=		"Number of buffs per line"
Locales["eng"]["heightBuffCntText"]	=		"Number of lines of buffs"
Locales["eng"]["heightGroupText"]	=		"Group Height"
Locales["eng"]["widthGroupText"]	=		"Group Num"
Locales["eng"]["sizeBuffGroupText"]	=		"Buff size"
Locales["eng"]["buffOnMe"]	=				"This is the buffs on me:"
Locales["eng"]["buffOnTarget"]	=			"This is the buffs on target:"
Locales["eng"]["configBuffsHeader2"]	=	"Detected buffs on avatar"
Locales["eng"]["configGroupBuffsHeader"]=	"Change group settings:"
Locales["eng"]["editGroupBuffsButton"]=		"Change group:"
Locales["eng"]["saveGroupBuffsButton"]=		"Save"
Locales["eng"]["addDebuffButton"]=			"Add: "
Locales["eng"]["addMobsButton"]=			"Add: "
Locales["eng"]["addControlButton"]=			"Add: "
Locales["eng"]["addGroupBuffsButton"]=		"Add group: "
Locales["eng"]["addBuffsButton"]=			"Add: "
Locales["eng"]["priorButton"]=				"Priority mode"
Locales["eng"]["autoDebuffModeButton"]=		"Auto detect debuffs on friends:"
Locales["eng"]["autoDebuffModeButtonUnk"]=	"Auto detect debuffs on friends:"
Locales["eng"]["woundsShowButton"]=			"Show wounds:"
Locales["eng"]["checkEnemyCleanable"]=		"Dispelling buffs on enemy:"
Locales["eng"]["checkEnemyCleanableUnk"]=	"Dispelling buffs on enemy:"
Locales["eng"]["shiftButton"]=				"Shift"
Locales["eng"]["ctrlButton"]=				"Ctrl"
Locales["eng"]["altButton"]=				"Alt"
Locales["eng"]["enemyButton"]=				"Enemy"
Locales["eng"]["targetButton"]=				"Show target"
Locales["eng"]["lastTargetButton"]=			"Show last target"
Locales["eng"]["classColorModeButton"]=		"Class color mode"
Locales["eng"]["firstShowButton"]=			"Avatar always first"
Locales["eng"]["selectModeButton"]  =		"Always select"
Locales["eng"]["buffsFixButton"]  =			"Fix on screen:"
Locales["eng"]["showManaButton"]=			"Show mana/energy"
Locales["eng"]["showShieldButton"]=			"Show shield"
Locales["eng"]["showServerNameButton"]=		"Show server"
Locales["eng"]["distanceText"]=				"Cast distance"
Locales["eng"]["highlightSelectedButton"]=	"Highlight target"
Locales["eng"]["showStandartRaidButton"]=	"Show standart raid/group interface"
Locales["eng"]["showClassIconButton"]=		"Show class icon"
Locales["eng"]["showDistanceButton"]=		"Show distance"
Locales["eng"]["showProcentButton"]=		"Show percent"
Locales["eng"]["showArrowButton"]=			"Show arrow"
Locales["eng"]["updateTimeBuffsButton"]=	"Update time"

Locales["eng"]["configProfilesHeader"]=		"Profiles: "
Locales["eng"]["saveAsProfileButton"]=		"Save current profile as: "
Locales["eng"]["profilesButton"]=			"Profiles"	

Locales["eng"]["inspectButton"]=			"Inspect"
Locales["eng"]["kickMenuButton"]=			"Kick"
Locales["eng"]["closeMenuButton"]=			"Close"
Locales["eng"]["leaveMenuButton"]=			"Leave group"
Locales["eng"]["raidLeaveMenuButton"]=		"Leave raid"
Locales["eng"]["leaderMenuButton"]=			"Set leader"

Locales["eng"]["freeLootMenuButton"]=		"Free loot"
Locales["eng"]["masterLootMenuButton"]=		"Master loot"
Locales["eng"]["groupLootMenuButton"]=		"Group loot"
Locales["eng"]["junkLootMenuButton"]=		"Junk"
Locales["eng"]["goodsLootMenuButton"]=		"Goods"
Locales["eng"]["commonLootMenuButton"]=		"Common"
Locales["eng"]["uncommonLootMenuButton"]=	"Uncommon"
Locales["eng"]["rareLootMenuButton"]=		"Rare"
Locales["eng"]["epicLootMenuButton"]=		"Epic"
Locales["eng"]["legendaryLootMenuButton"]=	"Legend"
Locales["eng"]["relicLootMenuButton"]=		"Relic"

Locales["eng"]["disbandMenuButton"]=		"Disband"
Locales["eng"]["inviteMenuButton"]=			"Invite"
Locales["eng"]["createRaidMenuButton"]=		"Create raid"
Locales["eng"]["createSmallRaidMenuButton"]="Create small raid"
Locales["eng"]["addLeaderHelperMenuButton"]="Set helper"
Locales["eng"]["addMasterLootMenuButton"]=	"Set loot master"
Locales["eng"]["deleteLeaderHelperMenuButton"]=	"Delete helper"
Locales["eng"]["deleteMasterLootMenuButton"]=	"Delete loot master"
Locales["eng"]["moveMenuButton"]=			"Move"
Locales["eng"]["whisperMenuButton"]=		"Whisper"

Locales["eng"]["configGroupBuffsId"]=		"ID"
Locales["eng"]["configGroupBuffsName"]=		"Name"
Locales["eng"]["configGroupBuffsTime"]=		"CD Time"
Locales["eng"]["configGroupBuffsCD"]  =		"CD"
Locales["eng"]["configGroupBuffsBuff"] =	"Buff"


Locales["eng"]["allShop"]=			{"Elixir of Proficiency", "Elixir of Brutality", "Elixir of Determination", "Elixir of Bloodlust", "Elixir of Vitality", "Elixir of Critical Chance",
									"Elixir of Willpower", "Elixir of Swiftness", "Elixir of Double Attack", "Elixir of Critical Damage", "Elixir of Elemental Damage", "Elixir of Holy Damage",
									"Elixir of Natural Damage", "Elixir of Physical Damage", "Elixir of Elemental Protection", "Elixir of Holy Protection", "Elixir of Natural Protection",
									"Elixir of Physical Protection", "Elixir of Survivability", "Elixir of Sustainability", "Elixir of Caution", "Elixir of Concentration",
									"Potion of Swiftness", "Potion of Critical Damage", "Potion of Double Attack", "Potion of Critical Chance", "Potion of Proficiency", "Potion of Willpower",
									"Potion of Bloodlust", "Potion of Vitality", "Potion of Brutality", "Potion of Determination", "Potion of Elemental Damage", "Potion of Holy Damage",
									"Potion of Natural Damage", "Potion of Physical Damage", "Potion of Elemental Protection", "Potion of Holy Protection", "Potion of Natural Protection",
									"Potion of Physical Protection", "Potion of Survivability", "Potion of Sustainability", "Potion of Caution", "Potion of Concentration",
									"Powerful Elixir of Proficiency", "Powerful Elixir of Brutality", "Powerful Elixir of Determination", "Powerful Elixir of Bloodlust", "Powerful Elixir of Vitality", 
									"Powerful Elixir of Critical Chance", "Powerful Elixir of Willpower", "Powerful Elixir of Swiftness", "Powerful Elixir of Double Attack", "Powerful Elixir of Critical Damage", 
									"Powerful Elixir of Elemental Damage", "Powerful Elixir of Holy Damage", "Powerful Elixir of Natural Damage", "Powerful Elixir of Physical Damage", "Powerful Elixir of Elemental Protection",
									"Powerful Elixir of Holy Protection", "Powerful Elixir of Natural Protection", "Powerful Elixir of Physical Protection", "Powerful Elixir of Survivability", 
									"Powerful Elixir of Sustainability", "Powerful Elixir of Caution", "Powerful Elixir of Concentration",
									"Demonic Potion of Proficiency", "Demonic Potion of Determination", "Demonic Potion of Brutality", "Arcanum of Natural Damage", "Arcanum of Elemental Damage",
									"Arcanum of Physical Damage", "Arcanum of Holy Damage",
									"Bitter Infusion", "Willpower", "Determination","Survivability"}


Locales["eng"]["defaultRessurectNames"]=	{ 	{ name = "��� �������" },
												{ name = "����������� �����" },
												{ name = "�����������" }
											}
Locales["eng"]["loadedMessage"] =			"Profile loaded: "
Locales["eng"]["savedMessage"] =			"Profile saved: "
Locales["eng"]["groupSavedMessage"] =		"Group saved."	
Locales["eng"]["build1Name"] =				"Build 1"	
Locales["eng"]["build2Name"] =				"Build 2"	

Locales["eng"]["gorisontalModeButton"] =	"Gorisontal mode"			
Locales["eng"]["twoxtwoModeButton"] =		"2x2 Mode: "
								
