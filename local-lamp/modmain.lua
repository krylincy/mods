STRINGS = GLOBAL.STRINGS
RECIPETABS = GLOBAL.RECIPETABS
Recipe = GLOBAL.Recipe
Ingredient = GLOBAL.Ingredient
TECH = GLOBAL.TECH
RECIPE_GAME_TYPE = GLOBAL.RECIPE_GAME_TYPE
		
PrefabFiles = {
    "goodlamp",
}

Assets=
{
    Asset("ATLAS", "images/inventoryimages/path_light.xml"),
}


local function AddModRecipe(_recName, _ingrList, _tab, _techLevel, _recType, _placer, _spacing, _proxyLock, _amount)
	if GLOBAL.IsDLCEnabled(GLOBAL.CAPY_DLC) or GLOBAL.IsDLCEnabled(GLOBAL.PORKLAND_DLC)  then
		return Recipe(_recName, _ingrList , _tab, _techLevel, _recType, _placer, _spacing, _proxyLock, _amount)
	else
		return Recipe(_recName, _ingrList , _tab, _techLevel, _placer, _spacing, _proxyLock, _amount)
	end
end

local goodlampRecipe = AddModRecipe("goodlampRecipe", {Ingredient("boards", 5),Ingredient("cutstone", 2),Ingredient("fireflies", 1)}, RECIPETABS.LIGHT, TECH.SCIENCE_ONE, RECIPE_GAME_TYPE.COMMON, 'goodlamp_placer')
goodlampRecipe.product = "goodlamp"
goodlampRecipe.image = "path_light.tex"
STRINGS.NAMES.GOODLAMP = "Lamp"
STRINGS.RECIPE_DESC.GOODLAMPRECIPE = "Off at day, on at dusk."

goodlampRecipe.atlas = "images/inventoryimages/path_light.xml"
goodlampRecipe.image = "path_light.tex"

STRINGS.NAMES.GOODLAMPRECIPE = "Lamp"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.GOODLAMPRECIPE = "A good Lamp"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.GOODLAMP = "A good Lamp"
