
STRINGS = GLOBAL.STRINGS
RECIPETABS = GLOBAL.RECIPETABS
RECIPE_GAME_TYPE = GLOBAL.RECIPE_GAME_TYPE
Recipe = GLOBAL.Recipe
Ingredient = GLOBAL.Ingredient
TECH = GLOBAL.TECH

PrefabFiles = {
    "aporkalypse_manager",
}

local function AddModRecipe(_recName, _ingrList, _tab, _techLevel, _recType, _placer, _spacing, _proxyLock, _amount)
	if GLOBAL.IsDLCEnabled(GLOBAL.CAPY_DLC) or GLOBAL.IsDLCEnabled(GLOBAL.PORKLAND_DLC)  then
		return Recipe(_recName, _ingrList , _tab, _techLevel, _recType, _placer, _spacing, _proxyLock, _amount)
	else
		return Recipe(_recName, _ingrList , _tab, _techLevel, _placer, _spacing, _proxyLock, _amount)
	end
end

local tier = GLOBAL.TECH.MAGIC_THREE
local modConfigIngredient


local RECIPE = {}


modConfigIngredient = GetModConfigData("RECIPE_TYPE_GOLDNUGGET")
if modConfigIngredient > 0 then
	table.insert(RECIPE, Ingredient("goldnugget", modConfigIngredient))
end

modConfigIngredient = GetModConfigData("RECIPE_TYPE_NIGHTMAREFUEL")
if modConfigIngredient > 0 then
	table.insert(RECIPE, Ingredient("nightmarefuel", modConfigIngredient))
end

modConfigIngredient = GetModConfigData("RECIPE_TYPE_PURPLEGEM")
if modConfigIngredient > 0 then
	table.insert(RECIPE, Ingredient("purplegem", modConfigIngredient))
end


local mod_recipe = AddModRecipe("mod_recipe", RECIPE, RECIPETABS.ARCHAEOLOGY, TECH.NONE, RECIPE_GAME_TYPE.PORKLAND)
mod_recipe.product = "aporkalypse_manager"
mod_recipe.image = "nightmare_timepiece.tex"
STRINGS.NAMES.MOD_RECIPE = "Aporkalypse Manager"
STRINGS.RECIPE_DESC.MOD_RECIPE = "With a start and stop engine."

STRINGS.NAMES.APORKALYPSE_MANAGER = "Aporkalypse Manager"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.APORKALYPSE_MANAGER = "Aporkalypse Manager with a start and stop engine."


