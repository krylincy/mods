Assets = 
{
	Asset("IMAGE", "images/inventoryimages/marblebean.tex"),
	Asset("ATLAS", "images/inventoryimages/marblebean.xml"),
	Asset("IMAGE", "minimap/marbleshrub.tex"),
	Asset("ATLAS", "minimap/marbleshrub.xml"),
}

PrefabFiles = 
{
	"marblebean",
	"marbleshrub",
	"planted_marbletree",
}

AddMinimapAtlas("minimap/marbleshrub.xml")

require = GLOBAL.require
local TUNING = GLOBAL.TUNING
local GetPlayer = GLOBAL.GetPlayer
local Combat = require "components/combat"
local follower = require "components/follower"
local harvestable = require "components/harvestable"
local ccanattack = Combat.CanAttack
local GetPlayer = GLOBAL.GetPlayer
local STRINGS = GLOBAL.STRINGS
local RECIPETABS = GLOBAL.RECIPETABS
local Recipe = GLOBAL.Recipe
local Ingredient = GLOBAL.Ingredient
local TECH = GLOBAL.TECH
local ACTIONS = GLOBAL.ACTIONS
local Vector3 = GLOBAL.Vector3
local distsq = GLOBAL.distsq
local GetWorld = GLOBAL.GetWorld
local Prefabs = GLOBAL.Prefabs
local Transform = GLOBAL.Transform
local Physics = GLOBAL.Physics
local AnimState = GLOBAL.AnimState
local FRAMES = GLOBAL.FRAMES
local DEGREES = GLOBAL.DEGREES
local SpawnPrefab = GLOBAL.SpawnPrefab
local TheCamera = GLOBAL.TheCamera
local seg_time = 30
local day_segs = 10
local dusk_segs = 4
local night_segs = 2
local day_time = seg_time * day_segs
local dusk_time = seg_time * dusk_segs
local night_time = seg_time * night_segs
local total_day_time = seg_time*16
local TheSim = GLOBAL.TheSim
local SpawnPrefab = GLOBAL.SpawnPrefab
local GetSeasonManager = GLOBAL.GetSeasonManager
local SEASONS = GLOBAL.SEASONS
local GetClock = GLOBAL.GetClock

TUNING.MARBLESHRUB_MINE_SMALL = 6
TUNING.MARBLESHRUB_MINE_NORMAL = 8
TUNING.MARBLESHRUB_MINE_TALL = 10
TUNING.MARBLESHRUB_MOD_GROW_TIME = GetModConfigData("marbleshrub_grow_time")
TUNING.MARBLESHRUB_GROW_TIME =
{
	{base=9.0 * day_time * TUNING.MARBLESHRUB_MOD_GROW_TIME, random=1.0 * day_time * TUNING.MARBLESHRUB_MOD_GROW_TIME}, --short
	{base=9.0 * day_time * TUNING.MARBLESHRUB_MOD_GROW_TIME, random=1.0 * day_time * TUNING.MARBLESHRUB_MOD_GROW_TIME}, --normal
	{base=9.0 * day_time, random=1.0 * day_time}, --tall
}

if GLOBAL.IsDLCEnabled(GLOBAL.CAPY_DLC) then
	local Rmarblebean = Recipe("marblebean",{Ingredient("marble",1)},RECIPETABS.REFINE,TECH.SCIENCE_TWO,GLOBAL.RECIPE_GAME_TYPE.COMMON)
	Rmarblebean.atlas = "images/inventoryimages/marblebean.xml"
	Rmarblebean.image = "marblebean.tex" 
else
	local Rmarblebean = Recipe("marblebean",{Ingredient("marble",1)},RECIPETABS.REFINE,TECH.SCIENCE_TWO)
	Rmarblebean.atlas = "images/inventoryimages/marblebean.xml"
	Rmarblebean.image = "marblebean.tex" 
end