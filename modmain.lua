PrefabFiles = {
	"mutantbeecocoon",
	"mutantbee",
	"mutantbeehive",
	"zeta",
	"armor_honey"
}

Assets = {
    Asset( "IMAGE", "images/saveslot_portraits/zeta.tex" ),
    Asset( "ATLAS", "images/saveslot_portraits/zeta.xml" ),

    Asset( "IMAGE", "images/selectscreen_portraits/zeta.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/zeta.xml" ),

    Asset( "IMAGE", "images/selectscreen_portraits/zeta_silho.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/zeta_silho.xml" ),

    Asset( "IMAGE", "bigportraits/zeta.tex" ),
    Asset( "ATLAS", "bigportraits/zeta.xml" ),

	Asset( "IMAGE", "images/map_icons/zeta.tex" ),
	Asset( "ATLAS", "images/map_icons/zeta.xml" ),
	Asset( "IMAGE", "images/map_icons/mutantbeecocoon.tex" ),
	Asset( "ATLAS", "images/map_icons/mutantbeecocoon.xml" ),

	Asset( "IMAGE", "images/avatars/avatar_zeta.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_zeta.xml" ),

	Asset( "IMAGE", "images/avatars/avatar_ghost_zeta.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_ghost_zeta.xml" ),

	Asset( "IMAGE", "images/avatars/self_inspect_zeta.tex" ),
    Asset( "ATLAS", "images/avatars/self_inspect_zeta.xml" ),

	Asset( "IMAGE", "images/names_zeta.tex" ),
    Asset( "ATLAS", "images/names_zeta.xml" ),

    Asset( "IMAGE", "bigportraits/zeta_none.tex" ),
    Asset( "ATLAS", "bigportraits/zeta_none.xml" ),

    Asset("SOUNDPACKAGE", "sound/zeta.fev"),
    Asset("SOUND", "sound/zeta.fsb"),
}

local function CheckDlcEnabled(dlc)
	-- if the constant doesn't even exist, then they can't have the DLC
	if not GLOBAL.rawget(GLOBAL, dlc) then return false end
	GLOBAL.assert(GLOBAL.rawget(GLOBAL, "IsDLCEnabled"), "Old version of game, please update (IsDLCEnabled function missing)")
	return GLOBAL.IsDLCEnabled(GLOBAL[dlc])
end

RemapSoundEvent( "dontstarve/characters/zeta/hurt", "zeta/zeta/hurt" )
RemapSoundEvent( "dontstarve/characters/zeta/talk_LP", "zeta/zeta/talk_LP" )
RemapSoundEvent( "dontstarve/characters/zeta/death_voice", "zeta/zeta/death_voice" )


local require = GLOBAL.require
local STRINGS = GLOBAL.STRINGS
local TUNING = GLOBAL.TUNING
local Ingredient = GLOBAL.Ingredient
local RECIPETABS = GLOBAL.RECIPETABS
local TECH = GLOBAL.TECH

-- Stats
TUNING.OZZY_MAX_HEALTH = 175
TUNING.OZZY_MAX_SANITY = 100
TUNING.OZZY_MAX_HUNGER = 125
TUNING.OZZY_DEFAULT_DAMAGE_MULTIPLIER = 0.75
TUNING.OZZY_HUNGER_SCALE = 1.1
TUNING.OZZY_NUM_PETALS_PER_HONEY = 5
TUNING.OZZY_SHARE_TARGET_DIST = 30
TUNING.OZZY_MAX_SHARE_TARGETS = 20
TUNING.OZZY_DEFAUT_SPEED_MULTIPLIER = 0
TUNING.OZZY_SPRING_SPEED_MULTIPLIER = 0.15
TUNING.OZZY_WINTER_SPEED_MULTIPLIER = -0.15
TUNING.OZZY_MAX_SUMMON_BEES = 3
TUNING.OZZY_SUMMON_CHANCE = 0.3
TUNING.OZZY_MAX_BEES_STORE = 7

-- Mutant bee stats
TUNING.MUTANT_BEE_HEALTH = 100
TUNING.MUTANT_BEE_DAMAGE = 10
TUNING.MUTANT_BEE_ATTACK_PERIOD = 1
TUNING.MUTANT_BEE_TARGET_DIST = 8
TUNING.MUTANT_BEE_MAX_POISON_TICKS = 5
TUNING.MUTANT_BEE_POISON_DAMAGE = -5
TUNING.MUTANT_BEE_POISON_PERIOD = 0.75
TUNING.MUTANT_BEE_EXPLOSIVE_DAMAGE_MULTIPLIER = 3.0
TUNING.MUTANT_BEE_EXPLOSIVE_RANGE = 8
TUNING.MUTANT_BEE_FROSTBITE_SPEED_PENALTY_MIN = 0.3
TUNING.MUTANT_BEE_FROSTBITE_SPEED_PENALTY_MAX = 0.6
TUNING.MUTANT_BEE_FROSTBITE_ATK_PERIOD_PENALTY_MIN = 1.35
TUNING.MUTANT_BEE_FROSTBITE_ATK_PERIOD_PENALTY_MAX = 1.65
TUNING.MUTANT_BEE_COLDNESS_ADD = 0.5
TUNING.MUTANT_BEE_WEAPON_ATK_RANGE = 10
TUNING.MUTANT_BEE_RANGED_TARGET_DIST = 10
TUNING.MUTANT_BEE_RANGED_ATK_HEALTH_PENALTY = 1 / 10
TUNING.MUTANT_BEE_RANGED_DAMAGE = 15
TUNING.MUTANT_BEE_RANGED_ATK_PERIOD = 2.5

-- Mutant beehive stats
TUNING.MUTANT_BEEHIVE_BEES = 5
TUNING.MUTANT_BEEHIVE_DEFAULT_RELEASE_TIME = 50
TUNING.MUTANT_BEEHIVE_DEFAULT_REGEN_TIME = 30
TUNING.MUTANT_BEEHIVE_DELTA_BEES = 1
TUNING.MUTANT_BEEHIVE_DELTA_RELEASE_TIME = 5
TUNING.MUTANT_BEEHIVE_DELTA_REGEN_TIME = 5
TUNING.MUTANT_BEEHIVE_UPGRADES_PER_STAGE = 3
TUNING.MUTANT_BEEHIVE_WATCH_DIST = 30
TUNING.MUTANT_BEEHIVE_RECOVER_PER_CHILD = 0.75
TUNING.MUTANT_BEEHIVE_GROW_TIME = {TUNING.TOTAL_DAY_TIME * 8, TUNING.TOTAL_DAY_TIME * 8}

-- Armor honey
TUNING.ARMORHONEY_MAX_ABSORPTION = 0.55
TUNING.ARMORHONEY_MIN_ABSORPTION = 0.3
TUNING.ARMORHONEY_HEAL_TICKS = 5
TUNING.ARMORHONEY_HEAL_INTERVAL = 1
TUNING.ARMORHONEY_MIN_HEAL_PERCENT = 0.01
TUNING.ARMORHONEY_MAX_HEAL_PERCENT = 0.03
TUNING.ARMORHONEY_MIN_HEAL_EXTRA = 1
TUNING.ARMORHONEY_MAX_HEAL_EXTRA = 3

-- Mod config
local num_bees = GetModConfigData("NUM_BEES_IN_HIVE")
TUNING.MUTANT_BEEHIVE_BEES = TUNING.MUTANT_BEEHIVE_BEES + num_bees * 2
TUNING.MUTANT_BEEHIVE_DEFAULT_REGEN_TIME = TUNING.MUTANT_BEEHIVE_DEFAULT_REGEN_TIME - num_bees * 10

local bee_damage = GetModConfigData("BEE_DAMAGE")
TUNING.MUTANT_BEE_DAMAGE = TUNING.MUTANT_BEE_DAMAGE + bee_damage * 5
TUNING.MUTANT_BEE_ATTACK_PERIOD = TUNING.MUTANT_BEE_ATTACK_PERIOD - bee_damage * 0.5
TUNING.MUTANT_BEE_POISON_DAMAGE = TUNING.MUTANT_BEE_POISON_DAMAGE - bee_damage * 2
TUNING.MUTANT_BEE_RANGED_DAMAGE = TUNING.MUTANT_BEE_RANGED_DAMAGE + bee_damage * 5
TUNING.MUTANT_BEE_RANGED_ATK_PERIOD = TUNING.MUTANT_BEE_RANGED_ATK_PERIOD - bee_damage * 1


-- The character select screen lines
STRINGS.CHARACTER_TITLES.zeta = "The Buzzy"
STRINGS.CHARACTER_NAMES.zeta = "Ozzy"
STRINGS.CHARACTER_DESCRIPTIONS.zeta = "*Has his own hive\n*Produces honey by eating petals\n*Summons bees by chance on attack"
STRINGS.CHARACTER_QUOTES.zeta = "\"Let's beefriend!\""

-- Custom speech strings
STRINGS.CHARACTERS.ZETA = require "speech_zeta"

-- The character's name as appears in-game
STRINGS.NAMES.ZETA = "Ozzy"

AddMinimapAtlas("images/map_icons/zeta.xml")
AddMinimapAtlas("images/map_icons/mutantbeecocoon.xml")

-- Add mod character to mod character list. Also specify a gender. Possible genders are MALE, FEMALE, ROBOT, NEUTRAL, and PLURAL.
AddModCharacter("zeta", "MALE")

local function CanUpgradeMetapisHive(inst, target, doer)
	return doer:HasTag("beemaster")
end

local function MakeHoneycombUpgrader(prefab)
	if not prefab.components.upgrader then
		prefab:AddComponent("upgrader")
		prefab.components.upgrader.canupgradefn = CanUpgradeMetapisHive
		prefab.components.upgrader.upgradetype = "METAPIS"
	end
end

AddPrefabPostInit("honeycomb", MakeHoneycombUpgrader)

local Recipe = GLOBAL.Recipe

local myrecipe = Recipe("mutantbeecocoon",
	{
		Ingredient("honeycomb", 1),
		Ingredient("cutgrass", 4),
		Ingredient("honey", 1)
	},
	RECIPETABS.SURVIVAL,
	TECH.NONE
)
myrecipe.atlas = "images/inventoryimages/mutantbeecocoon.xml"

local myrecipe = Recipe("armorhoney",
	{
		Ingredient("log", 10),
		Ingredient("rope", 1),
		Ingredient("honey", 3)
	},
	RECIPETABS.WAR,
	TECH.NONE
)
myrecipe.atlas = "images/inventoryimages/armorhoney.xml"
