STRINGS = GLOBAL.STRINGS
RECIPETABS = GLOBAL.RECIPETABS
Ingredient = GLOBAL.Ingredient
TECH = GLOBAL.TECH
RECIPE_GAME_TYPE = GLOBAL.RECIPE_GAME_TYPE
ACTIONS = GLOBAL.ACTIONS
SpawnPrefab = GLOBAL.SpawnPrefab

Assets = {
    Asset("IMAGE", "images/hedge_block_cut.tex"),
    Asset("ATLAS", "images/hedge_block_cut.xml"),
    Asset("IMAGE", "images/hedge_cone_cut.tex"),
    Asset("ATLAS", "images/hedge_cone_cut.xml"),
    Asset("IMAGE", "images/hedge_layered_cut.tex"),
    Asset("ATLAS", "images/hedge_layered_cut.xml"),
    Asset("IMAGE", "images/lawnornament_1.tex"),
    Asset("ATLAS", "images/lawnornament_1.xml"),
    Asset("IMAGE", "images/lawnornament_2.tex"),
    Asset("ATLAS", "images/lawnornament_2.xml"),
    Asset("IMAGE", "images/lawnornament_3.tex"),
    Asset("ATLAS", "images/lawnornament_3.xml"),
    Asset("IMAGE", "images/lawnornament_4.tex"),
    Asset("ATLAS", "images/lawnornament_4.xml"),
    Asset("IMAGE", "images/lawnornament_5.tex"),
    Asset("ATLAS", "images/lawnornament_5.xml"),
    Asset("IMAGE", "images/lawnornament_6.tex"),
    Asset("ATLAS", "images/lawnornament_6.xml"),
    Asset("IMAGE", "images/lawnornament_7.tex"),
    Asset("ATLAS", "images/lawnornament_7.xml"),
}

PrefabFiles = {
	"hedge_block_placer",
	"hedge_cone_placer",
	"hedge_layered_placer",
	"lawnornament_1_placer",
	"lawnornament_2_placer",
	"lawnornament_3_placer",
	"lawnornament_4_placer",
	"lawnornament_5_placer",
	"lawnornament_6_placer",
	"lawnornament_7_placer",
}

local WORKABLE_HEDGES = GetModConfigData("WORKABLE_HEDGES")
local WORKABLE_LAWNORNAMENT = GetModConfigData("WORKABLE_LAWNORNAMENT")
local OINCS_HEDGES = GetModConfigData("OINCS_HEDGES")
local OINCS_LAWNORNAMENT = GetModConfigData("OINCS_LAWNORNAMENT")

local function AddModRecipe(_name, _ingredients, _tab, _level, _game_type, _placer, _min_spacing, _nounlock, _numtogive, _aquatic, _distance, _decor, _flipable, _image, _wallitem)
	if GLOBAL.IsDLCEnabled(GLOBAL.CAPY_DLC) or GLOBAL.IsDLCEnabled(GLOBAL.PORKLAND_DLC)  then
		return GLOBAL.Recipe(_name, _ingredients , _tab, _level, _game_type, _placer, _min_spacing, _nounlock, _numtogive, _aquatic, _distance, _decor, _flipable, _image, _wallitem)
	else
		return GLOBAL.Recipe(_name, _ingredients , _tab, _level, _placer, _min_spacing, _nounlock, _numtogive)
	end
end

local lawnornament = {}
local function lawnornamentSetup(frame)

	local name = "lawnornament_"..frame
	local recipe = "lawnornament_recipe"..frame
	local placer = name.."_placer"

	lawnornament[name] = AddModRecipe(recipe, {Ingredient("oinc",OINCS_LAWNORNAMENT)}, RECIPETABS.CITY, TECH.CITY, RECIPE_GAME_TYPE.COMMON, placer, 0)
	lawnornament[name].product = name
	lawnornament[name].atlas = "images/"..name..".xml"
	lawnornament[name].image = name..".tex"
	lawnornament[name].numtogive = 1
	STRINGS.NAMES["LAWNORNAMENT_RECIPE"..frame] = "Lawn Decoration "..frame
	STRINGS.RECIPE_DESC["LAWNORNAMENT_RECIPE"..frame] = ""

	
	
	AddPrefabPostInit(name, function(inst) 
		if WORKABLE_LAWNORNAMENT then
			inst:RemoveComponent("fixable")
		end
	end)
	
	AddPrefabPostInit(placer, function(inst) 
		inst.AnimState:Hide("snow")
	end)

end

local hedge = {}
local function hedgeSetup(frame)

	local name = "hedge_"..frame
	local recipe = "hedge_recipe_"..frame
	local recipeStringName = "HEDGE_RECIPE_"..string.upper(frame)
	local placer = name.."_placer"

	hedge[name] = AddModRecipe(recipe, {Ingredient("oinc",OINCS_HEDGES)}, RECIPETABS.CITY, TECH.CITY, RECIPE_GAME_TYPE.COMMON, placer, 0)
	hedge[name].product = name
	hedge[name].atlas = "images/"..name.."_cut.xml"
	hedge[name].image = name.."_cut.tex"
	hedge[name].numtogive = 1
	STRINGS.NAMES[recipeStringName] = "Hedge "..frame
	STRINGS.RECIPE_DESC[recipeStringName] = "A "..frame.."-shaped bush"


	AddPrefabPostInit(name, function(inst) 
		local function onhammered(inst, worker)	
			SpawnPrefab("collapse_small").Transform:SetPosition(inst.Transform:GetWorldPosition())		
			inst.SoundEmitter:PlaySound("dontstarve/common/destroy_stone")	
			
			inst:Remove()
		end
		
		if WORKABLE_HEDGES then
			inst:AddComponent("workable")
			inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
			inst.components.workable:SetWorkLeft(3)
			inst.components.workable:SetOnFinishCallback(onhammered)
			inst.components.workable:SetOnWorkCallback(onhit) 
		end
		
		inst:RemoveComponent("deployable")
	end)
end

hedgeSetup("block")
hedgeSetup("cone")
hedgeSetup("layered")

lawnornamentSetup(1)
lawnornamentSetup(2)
lawnornamentSetup(3)
lawnornamentSetup(4)
lawnornamentSetup(5)
lawnornamentSetup(6)
lawnornamentSetup(7)

