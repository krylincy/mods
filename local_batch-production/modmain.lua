STRINGS = GLOBAL.STRINGS
RECIPETABS = GLOBAL.RECIPETABS
Recipe = GLOBAL.Recipe
Ingredient = GLOBAL.Ingredient
TECH = GLOBAL.TECH

local function AddModRecipe(_recName, _ingrList, _tab, _techLevel, _recType, _placer, _spacing, _proxyLock, _amount)
	if GLOBAL.CAPY_DLC and GLOBAL.IsDLCEnabled(GLOBAL.CAPY_DLC) or GLOBAL.IsDLCEnabled(GLOBAL.PORKLAND_DLC) then
		return GLOBAL.Recipe(_recName, _ingrList , _tab, _techLevel, _recType, _placer, _spacing, _proxyLock, _amount)
	else
		return GLOBAL.Recipe(_recName, _ingrList , _tab, _techLevel, _placer, _spacing, _proxyLock, _amount)
	end
end


local ropebatch = AddModRecipe("ropebatch", {Ingredient("cutgrass", 30)}, RECIPETABS.REFINE,  TECH.SCIENCE_ONE)
ropebatch.product = "rope"
ropebatch.image = "rope.tex"
ropebatch.numtogive = 10
STRINGS.NAMES.ROPEBATCH = "Rope 10x"
STRINGS.RECIPE_DESC.ROPEBATCH = "Tightly woven coils of usefulness."

local boardsbatch = AddModRecipe("boardsbatch", {Ingredient("log", 40)}, RECIPETABS.REFINE,  TECH.SCIENCE_ONE)
boardsbatch.product = "boards"
boardsbatch.image = "boards.tex"
boardsbatch.numtogive = 10
STRINGS.NAMES.BOARDSBATCH = "Boards 10x"
STRINGS.RECIPE_DESC.BOARDSBATCH = "Like logs but flatter."

local cutstonebatch = AddModRecipe("cutstonebatch", {Ingredient("rocks", 30)}, RECIPETABS.REFINE,  TECH.SCIENCE_ONE)
cutstonebatch.product = "cutstone"
cutstonebatch.image = "cutstone.tex"
cutstonebatch.numtogive = 10
STRINGS.NAMES.CUTSTONEBATCH = "Cutstone 10x"
STRINGS.RECIPE_DESC.CUTSTONEBATCH = "Nicely squared rocks."

local papyrusbatch = AddModRecipe("papyrusbatch", {Ingredient("cutreeds", 40)}, RECIPETABS.REFINE,  TECH.SCIENCE_ONE)
papyrusbatch.product = "papyrus"
papyrusbatch.image = "papyrus.tex"
papyrusbatch.numtogive = 10
STRINGS.NAMES.PAPYRUSBATCH = "Papyrus 10x"
STRINGS.RECIPE_DESC.PAPYRUSBATCH = "For writing things."

local bandagebatch = AddModRecipe("bandagebatch", {Ingredient("papyrus", 10), Ingredient("honey", 20)}, RECIPETABS.SURVIVAL,  TECH.SCIENCE_TWO)
bandagebatch.product = "bandage"
bandagebatch.image = "bandage.tex"
bandagebatch.numtogive = 10
STRINGS.NAMES.BANDAGEBATCH = "Bandage 10x"
STRINGS.RECIPE_DESC.BANDAGEBATCH = "Heal your minor wounds."

local healingsalvebatch = AddModRecipe("healingsalvebatch", {Ingredient("ash", 20), Ingredient("rocks", 10), Ingredient("spidergland",10)}, RECIPETABS.SURVIVAL, TECH.SCIENCE_ONE)
healingsalvebatch.product = "healingsalve"
healingsalvebatch.image = "healingsalve.tex"
healingsalvebatch.numtogive = 10
STRINGS.NAMES.HEALINGSALVEBATCH = "Healingsalve 10x"
STRINGS.RECIPE_DESC.HEALINGSALVEBATCH = "Disinfectant for cuts and abrasions."

