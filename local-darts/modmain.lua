STRINGS = GLOBAL.STRINGS
RECIPETABS = GLOBAL.RECIPETABS
Recipe = GLOBAL.Recipe
RECIPE_GAME_TYPE = GLOBAL.RECIPE_GAME_TYPE
Ingredient = GLOBAL.Ingredient
TECH = GLOBAL.TECH

local mergedGameTypes = {RECIPE_GAME_TYPE.VANILLA,RECIPE_GAME_TYPE.SHIPWRECKED,RECIPE_GAME_TYPE.ROG,RECIPE_GAME_TYPE.PORKLAND}
local cityRecipeGameTypes = RECIPE_GAME_TYPE.COMMON

local function AddModRecipe(_recName, _ingrList, _tab, _techLevel, _recType, _placer, _spacing, _proxyLock, _amount)
	if GLOBAL.CAPY_DLC and GLOBAL.IsDLCEnabled(GLOBAL.CAPY_DLC) or GLOBAL.IsDLCEnabled(GLOBAL.PORKLAND_DLC) then
		return GLOBAL.Recipe(_recName, _ingrList , _tab, _techLevel, _recType, _placer, _spacing, _proxyLock, _amount)
	else
		return GLOBAL.Recipe(_recName, _ingrList , _tab, _techLevel, _placer, _spacing, _proxyLock, _amount)
	end
end

local blowpipemulti = AddModRecipe("blowpipemulti", {Ingredient("twigs", 10)}, RECIPETABS.WAR, TECH.NONE)
blowpipemulti.product = "blowdart_pipe"
blowpipemulti.image = "blowdart_pipe.tex"
blowpipemulti.numtogive = 10
STRINGS.NAMES.BLOWPIPEMULTI = "Blow Darts x 10"
STRINGS.RECIPE_DESC.BLOWPIPEMULTI = "Spit more teeth at your enemies."

local staff_tornado_pay = AddModRecipe("staff_tornado_pay", {Ingredient("goldnugget", 5)}, RECIPETABS.WAR, TECH.NONE)
staff_tornado_pay.product = "staff_tornado"
staff_tornado_pay.image = "staff_tornado.tex"
staff_tornado_pay.numtogive = 1
STRINGS.NAMES.STAFF_TORNADO_PAY = "Weather Pain"
STRINGS.RECIPE_DESC.STAFF_TORNADO_PAY = "I Pay for your pain!"

local lightberry = AddModRecipe("lightberry", {Ingredient("lightbulb", 8)}, RECIPETABS.LIGHT, TECH.SCIENCE_TWO)
lightberry.product = "wormlight"
lightberry.image = "wormlight.tex"
lightberry.numtogive = 3
STRINGS.NAMES.LIGHTBERRY = "Wormlight x 3"
STRINGS.RECIPE_DESC.LIGHTBERRY = "Now I see you"

local key_to_city = AddModRecipe("key_to_city", {Ingredient("goldnugget", 5)}, RECIPETABS.TOOLS,  TECH.SCIENCE_TWO, mergedGameTypes)
key_to_city.product = "key_to_city"
key_to_city.image = "key_to_city.tex"
key_to_city.numtogive = 1
STRINGS.NAMES.KEY_TO_CITY = "Key to the City"
STRINGS.RECIPE_DESC.KEY_TO_CITY = "Now I build my KINGDOM"

local city_hammer = AddModRecipe("city_hammer", {Ingredient("goldnugget", 5)}, RECIPETABS.TOOLS,  TECH.SCIENCE_TWO, mergedGameTypes)
city_hammer.product = "city_hammer"
city_hammer.image = "city_hammer.tex"
city_hammer.numtogive = 1
STRINGS.NAMES.CITY_HAMMER = "City Hammer"
STRINGS.RECIPE_DESC.CITY_HAMMER = "Now I destroy my KINGDOM"

local cityoinc = AddModRecipe("cityoinc", {Ingredient("goldnugget", 5)}, RECIPETABS.TOOLS,  TECH.SCIENCE_TWO, mergedGameTypes)
cityoinc.product = "oinc"
cityoinc.image = "oinc.tex"
cityoinc.numtogive = 20
STRINGS.NAMES.CITYOINC = "Oinc"
STRINGS.RECIPE_DESC.CITYOINC = "Oinc Oinc x20"

local babybeefalo = AddModRecipe("babybeefalo", {Ingredient("beefalowool", 5),Ingredient("horn", 1)}, RECIPETABS.FARM, TECH.NONE)
babybeefalo.image = "brush.tex"
STRINGS.NAMES.BABYBEEFALO = "Babybeefalo"
STRINGS.RECIPE_DESC.BABYBEEFALO = ""

local pog = AddModRecipe("pog", {Ingredient("smallmeat", 4),Ingredient("meat", 1),Ingredient("goldnugget", 1)}, RECIPETABS.FARM, TECH.NONE)
pog.image = "brush.tex"
STRINGS.NAMES.POG = "Pog"
STRINGS.RECIPE_DESC.POG = ""

local peagawk = AddModRecipe("peagawk", {Ingredient("drumstick", 2),Ingredient("meat", 1),Ingredient("doydoyfeather", 5)}, RECIPETABS.FARM, TECH.NONE)
peagawk.image = "brush.tex"
STRINGS.NAMES.PEAGAWK = "Peagawk"
STRINGS.RECIPE_DESC.PEAGAWK = ""

local doydoyfoodclipping = AddModRecipe("seeds_cooked", {Ingredient("clippings", 1)}, RECIPETABS.FARM, TECH.NONE)
doydoyfoodclipping.image = "seeds_cooked.tex"
doydoyfoodclipping.numtogive = 5
STRINGS.NAMES.DOYDOYFOODCLIPPING = "Toasted Seeds"
STRINGS.RECIPE_DESC.DOYDOYFOODCLIPPING = "Toasted Seeds x5"


--Recipe("beebox", {Ingredient("boards", 2),Ingredient("honeycomb", 1),Ingredient("bee", 4)}, RECIPETABS.FARM, TECH.SCIENCE_ONE, {RECIPE_GAME_TYPE.VANILLA,RECIPE_GAME_TYPE.ROG,RECIPE_GAME_TYPE.SHIPWRECKED}, "beebox_placer")

local beebox = AddModRecipe("beebox", {Ingredient("boards", 5),Ingredient("honeycomb", 1),Ingredient("stinger", 10)}, RECIPETABS.FARM, TECH.SCIENCE_ONE, mergedGameTypes, "beebox_placer")
--local living_artifact = AddModRecipe("living_artifact", {Ingredient("infused_iron", 6),Ingredient("waterdrop", 1)}, RECIPETABS.MAGIC, TECH.MAGIC_THREE, mergedGameTypes)
local pig_shop_antiquities = AddModRecipe("pig_shop_antiquities", {Ingredient("boards", 4), Ingredient("hammer", 3), Ingredient("pigskin", 4)}, RECIPETABS.CITY, TECH.CITY, cityRecipeGameTypes, "pig_shop_antiquities_placer", nil, true)
--Recipe("hedge_block_item", {Ingredient("clippings", 9), Ingredient("nitre", 1)}, RECIPETABS.CITY, TECH.CITY, cityRecipeGameTypes, nil, nil, true, 3)
local hedge_block_item = AddModRecipe("hedge_block_item", {Ingredient("boards", 1), Ingredient("nitre", 1)}, RECIPETABS.CITY, TECH.CITY, cityRecipeGameTypes, nil, nil, true, 3)
local pig_shop_tinker = AddModRecipe("pig_shop_tinker", {Ingredient("cutstone", 4), Ingredient("pitchfork", 3), Ingredient("pigskin", 4)}, RECIPETABS.CITY, TECH.CITY, cityRecipeGameTypes, "pig_shop_tinker_placer", nil, true)
local playerhouse_city = AddModRecipe("playerhouse_city", {Ingredient("boards", 5), Ingredient("cutstone", 5)}, RECIPETABS.CITY, TECH.NONE, mergedGameTypes, "playerhouse_city_placer", nil, true)
--Recipe("construction_permit", {Ingredient("oinc", 50)}, RECIPETABS.HOME, TECH.HOME_TWO, cityRecipeGameTypes, nil, nil, true)
local construction_permit = AddModRecipe("construction_permit", {Ingredient("oinc", 10)}, RECIPETABS.HOME, TECH.HOME_TWO, cityRecipeGameTypes, nil, nil, true)
local city_lamp = AddModRecipe("city_lamp", {Ingredient("cutstone", 2), Ingredient("transistor", 1),Ingredient("lightbulb",5)}, RECIPETABS.CITY, TECH.NONE, cityRecipeGameTypes, "city_lamp_placer", nil, true)
local turf_foundation = AddModRecipe("turf_foundation", {Ingredient("cutstone", 1)}, RECIPETABS.CITY, TECH.CITY, cityRecipeGameTypes, nil, nil, true)
turf_foundation.numtogive = 5
local turf_cobbleroad = AddModRecipe("turf_cobbleroad", {Ingredient("cutstone", 1), Ingredient("boards", 1)}, RECIPETABS.CITY, TECH.CITY, cityRecipeGameTypes, nil, nil, true)
turf_cobbleroad.numtogive = 5
local thulecite = AddModRecipe("thulecite", {Ingredient("rocks", 1), Ingredient("goldnugget", 2)}, RECIPETABS.ANCIENT, TECH.ANCIENT_FOUR, mergedGameTypes, nil, nil, true)




