
RECIPETABS = GLOBAL.RECIPETABS
RECIPE_GAME_TYPE = GLOBAL.RECIPE_GAME_TYPE
Recipe = GLOBAL.Recipe
Ingredient = GLOBAL.Ingredient
TECH = GLOBAL.TECH
TUNING = GLOBAL.TUNING
		
PrefabFiles = {
    "doydoypet",
    "doydoypetegg",
	"seed_grass",
	"dug_seed_grass",
}

Assets = {
    Asset("IMAGE", "images/doydoypetegg.tex"),
    Asset("ATLAS", "images/doydoypetegg.xml"),
    Asset("IMAGE", "images/seed_grass.tex"),
    Asset("ATLAS", "images/seed_grass.xml"),
}

GLOBAL.STRINGS.NAMES.DOYDOYPET = "Doydoy Pet"
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.DOYDOYPET = "I feel oddly protective of this dumb bird."

GLOBAL.STRINGS.NAMES.DOYDOYPETBABY = "Doydoy Pet Baby"
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.DOYDOYPETBABY = "I feel oddly protective of this dumb bird."

GLOBAL.STRINGS.NAMES.DOYDOYPETEGG = "Doydoy Pet Egg"
GLOBAL.STRINGS.RECIPE_DESC.DOYDOYPETEGG = "Maybe I should have let it hatch."
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.DOYDOYPETEGG = "Maybe I should have let it hatch."

GLOBAL.STRINGS.NAMES.DUG_SEED_GRASS = "Seed Grass"
GLOBAL.STRINGS.RECIPE_DESC.DUG_SEED_GRASS = "Seed Grass"
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.DUG_SEED_GRASS = "Harvest one seed per day"

GLOBAL.STRINGS.NAMES.SEED_GRASS = "Seed Grass"
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.SEED_GRASS = "A cornucopia!"

GLOBAL.STRINGS.NAMES.DOYDOYPETEGG_CRACKED = "Doydoy Pet Egg"
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.DOYDOYPETEGG_CRACKED = "Maybe I should have let it hatch."

GLOBAL.STRINGS.NAMES.DOYDOYPETEGG_COOKED = "Doydoy Pet Egg Cooked"
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.DOYDOYPETEGG_COOKED = "Your time is over."
GLOBAL.STRINGS.RECIPE_DESC.DOYDOYPETEGG_COOKED = "Your time is over."

local seg_time = 30
local total_day_time = seg_time*16 --480
local EAT_INVERVALL = GetModConfigData("DOYDOYPET_EAT_INVERVALL")

TUNING.DOYDOYPET_BABY_HEALTH = 50
TUNING.DOYDOYPET_BABY_WALK_SPEED = 5

TUNING.DOYDOYPET_TEEN_HEALTH = 65
TUNING.DOYDOYPET_TEEN_WALK_SPEED = 3

TUNING.DOYDOYPET_HEALTH = 85
TUNING.DOYDOYPET_WALK_SPEED = 2

TUNING.DOYDOYPET_SEE_FOOD_DIST = GetModConfigData("DOYDOYPET_SEE_FOOD_DIST")
TUNING.DOYDOYPET_MAX_WANDER_DIST = GetModConfigData("DOYDOYPET_SEE_FOOD_DIST") * 4

TUNING.DOYDOYPET_EAT_PER_DAY = EAT_INVERVALL

TUNING.DOYDOYPET_TO_TEEN = EAT_INVERVALL / 2
TUNING.DOYDOYPET_TO_ADULT = EAT_INVERVALL + TUNING.DOYDOYPET_TO_TEEN

TUNING.DOYDOYPET_DIE_OLD_AGE = GetModConfigData("DOYDOYPET_DIE_OLD_AGE")
TUNING.DOYDOYPET_EAT_INVERVALL = (total_day_time / EAT_INVERVALL)

TUNING.DOYDOYPET_BREED_CHANCE = 0.8 --1.6 / EAT_INVERVALL


local doydoypeteggMenu
local doydoypeteggRecipe = {Ingredient("bird_egg", 5), Ingredient("wetgoop", 1)}

local doydoypetfoodMenu
local doydoypetfoodRecipe = {Ingredient("seeds", 20), Ingredient("poop", 1)}

if GLOBAL.IsDLCEnabled(GLOBAL.CAPY_DLC) or GLOBAL.IsDLCEnabled(GLOBAL.PORKLAND_DLC) then
	doydoypeteggMenu = Recipe("doydoypetegg",doydoypeteggRecipe , RECIPETABS.FARM, TECH.SCIENCE_ONE, RECIPE_GAME_TYPE.COMMON, nil, 1)
	doydoypetfoodMenu = Recipe("dug_seed_grass",doydoypetfoodRecipe , RECIPETABS.FARM, TECH.SCIENCE_ONE, RECIPE_GAME_TYPE.COMMON, nil, 1)
    doydoypetfoodMenu.numtogive = 5
else
	doydoypeteggMenu = Recipe("doydoypetegg",doydoypeteggRecipe , RECIPETABS.FARM, TECH.SCIENCE_ONE, nil, 1)
	doydoypetfoodMenu = Recipe("dug_seed_grass",doydoypetfoodRecipe , RECIPETABS.FARM, TECH.SCIENCE_ONE, nil, 1)
    doydoypetfoodMenu.numtogive = 5
end

doydoypeteggMenu.atlas = "images/doydoypetegg.xml"
doydoypeteggMenu.image = "doydoypetegg.tex"

doydoypetfoodMenu.atlas = "images/seed_grass.xml"
doydoypetfoodMenu.image = "seed_grass.tex"