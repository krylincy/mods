
STRINGS = GLOBAL.STRINGS
RECIPETABS = GLOBAL.RECIPETABS
Recipe = GLOBAL.Recipe
Ingredient = GLOBAL.Ingredient
TECH = GLOBAL.TECH

-----krampus_sack_recipe-----
local function AddModRecipe(_recName, _ingrList, _tab, _techLevel, _recType, _placer, _spacing, _proxyLock, _amount)
	if GLOBAL.IsDLCEnabled(GLOBAL.CAPY_DLC) or GLOBAL.IsDLCEnabled(GLOBAL.PORKLAND_DLC)  then
		return Recipe(_recName, _ingrList , _tab, _techLevel, _recType, _placer, _spacing, _proxyLock, _amount)
	else
		return Recipe(_recName, _ingrList , _tab, _techLevel, _placer, _spacing, _proxyLock, _amount)
	end
end

local machine = GetModConfigData("machine")
local tier = GLOBAL.TECH.NONE
local modConfigIngredient

if machine == 1 then
	tier = GLOBAL.TECH.SCIENCE_ONE
elseif machine == 2 then
	tier = GLOBAL.TECH.SCIENCE_TWO
	elseif machine == 3 then
	tier = GLOBAL.TECH.MAGIC_TWO
elseif machine == 4 then
	tier = GLOBAL.TECH.MAGIC_THREE
elseif machine == 5 then
	tier = GLOBAL.TECH.ANCIENT_TWO
end

local RECIPE = {}


modConfigIngredient = GetModConfigData("RECIPE_TYPE_CUTREEDS")
if modConfigIngredient > 0 then
	table.insert(RECIPE, Ingredient("cutreeds", modConfigIngredient))
end

modConfigIngredient = GetModConfigData("RECIPE_TYPE_PAPYRUS")
if modConfigIngredient > 0 then
	table.insert(RECIPE, Ingredient("papyrus", modConfigIngredient))
end

modConfigIngredient = GetModConfigData("RECIPE_TYPE_ROPE")
if modConfigIngredient > 0 then
	table.insert(RECIPE, Ingredient("rope", modConfigIngredient))
end

modConfigIngredient = GetModConfigData("RECIPE_TYPE_GOLDNUGGET")
if modConfigIngredient > 0 then
	table.insert(RECIPE, Ingredient("goldnugget", modConfigIngredient))
end

modConfigIngredient = GetModConfigData("RECIPE_TYPE_BEARGER_FUR")
if modConfigIngredient > 0 then
	table.insert(RECIPE, Ingredient("bearger_fur", modConfigIngredient))
end

modConfigIngredient = GetModConfigData("RECIPE_TYPE_DRAGON_SCALES")
if modConfigIngredient > 0 then
	table.insert(RECIPE, Ingredient("dragon_scales", modConfigIngredient))
end

modConfigIngredient = GetModConfigData("RECIPE_TYPE_CHARCOAL")
if modConfigIngredient > 0 then
	table.insert(RECIPE, Ingredient("charcoal", modConfigIngredient))
end

local krampus_sack_recipe = AddModRecipe("krampus_sack_recipe", RECIPE, RECIPETABS.SURVIVAL, tier)
krampus_sack_recipe.product = "krampus_sack"
krampus_sack_recipe.image = "krampus_sack.tex"
STRINGS.NAMES.KRAMPUS_SACK_RECIPE = "Krampus' Sack"
STRINGS.RECIPE_DESC.KRAMPUS_SACK_RECIPE = "+14 inventory slots"

local FRIDGE_FUNCTION = GetModConfigData("FRIDGE_FUNCTION")

if FRIDGE_FUNCTION == 2 then
	AddPrefabPostInit("krampus_sack", 
		function(inst) 
			inst:AddTag("fridge") 
			inst:AddTag("nocool")
		end
	)
end

if FRIDGE_FUNCTION == 3 then
	AddPrefabPostInit("krampus_sack", function(inst) inst:AddTag("fridge") end)
end

