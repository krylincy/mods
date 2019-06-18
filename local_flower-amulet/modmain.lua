STRINGS = GLOBAL.STRINGS
RECIPETABS = GLOBAL.RECIPETABS
Recipe = GLOBAL.Recipe
Ingredient = GLOBAL.Ingredient
TECH = GLOBAL.TECH
TUNING = GLOBAL.TUNING
		
PrefabFiles = {
    "floweramulet",
}

Assets = {
    Asset("IMAGE", "images/floweramulet.tex"),
    Asset("ATLAS", "images/floweramulet.xml"),
}

local function AddModRecipe(_recName, _ingrList, _tab, _techLevel, _recType, _placer, _spacing, _proxyLock, _amount)
	if GLOBAL.CAPY_DLC and GLOBAL.IsDLCEnabled(GLOBAL.CAPY_DLC) or GLOBAL.IsDLCEnabled(GLOBAL.PORKLAND_DLC) then
		return GLOBAL.Recipe(_recName, _ingrList , _tab, _techLevel, _recType, _placer, _spacing, _proxyLock, _amount)
	else
		return GLOBAL.Recipe(_recName, _ingrList , _tab, _techLevel, _placer, _spacing, _proxyLock, _amount)
	end
end

TUNING.FLOWERAMULET_DURABILITY = GetModConfigData("DURABILITY")

local floweramulet = AddModRecipe("floweramulet", {Ingredient("goldnugget", 15), Ingredient("petals", 15), Ingredient("butterflywings", 10)}, RECIPETABS.FARM,  TECH.SCIENCE_ONE)
floweramulet.product = "floweramulet"
floweramulet.numtogive = 1

floweramulet.atlas = "images/floweramulet.xml"
floweramulet.image = "floweramulet.tex"

STRINGS.NAMES.FLOWERAMULET = "Flower Amulet"
STRINGS.RECIPE_DESC.FLOWERAMULET = "With the Flower Amulet you can plant seeds everywhere."

STRINGS.CHARACTERS.GENERIC.DESCRIBE.FLOWERAMULET = "Nature is so amazing!"


