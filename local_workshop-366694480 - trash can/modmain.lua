PrefabFiles = 
{
	--FARM
	"ice_chest",
	"compost_box",
	
	--TOWN
	"crate_material",
	"crate_wooden",
	"crate_metal",
	"trash_can",
	"charcoal_pit",
}

Assets = 
{
	--FARM
	Asset("ATLAS", "images/inventoryimages/ice_chest.xml"),
	Asset("ATLAS", "images/inventoryimages/compost_box.xml"),
	
	--TOWN
	Asset("ATLAS", "images/inventoryimages/crate_material.xml"),
	Asset("ATLAS", "images/inventoryimages/crate_wooden.xml"),
	Asset("ATLAS", "images/inventoryimages/crate_metal.xml"),
	Asset("ATLAS", "images/inventoryimages/trash_can.xml"),
	Asset("ATLAS", "images/inventoryimages/charcoal_pit.xml"),
	
	--FARM
	Asset("ATLAS", "minimap/ice_chest.xml" ),
	Asset("ATLAS", "minimap/compost_box.xml" ),
	
	--TOWN
	Asset("ATLAS", "minimap/crate_material.xml" ),
	Asset("ATLAS", "minimap/crate_wooden.xml" ),
	Asset("ATLAS", "minimap/crate_metal.xml" ),
	Asset("ATLAS", "minimap/trash_can.xml" ),
	Asset("ATLAS", "minimap/charcoal_pit.xml" )
}


STRINGS 	= GLOBAL.STRINGS
RECIPETABS 	= GLOBAL.RECIPETABS
Recipe 		= GLOBAL.Recipe
TECH		= GLOBAL.TECH
Ingredient 	= GLOBAL.Ingredient

local as_alternate_recipe 			= GetModConfigData("as_alternate_recipe")
local ice_chest_Enable 				= GetModConfigData("ice_chest_Enable")
local compost_box_Enable 			= GetModConfigData("compost_box_Enable")
local crate_material_Enable			= GetModConfigData("crate_material_Enable")
local crate_wooden_Enable			= GetModConfigData("crate_wooden_Enable")
local crate_metal_Enable			= GetModConfigData("crate_metal_Enable")
local trash_can_Enable				= GetModConfigData("trash_can_Enable")
local charcoal_pit_Enable			= GetModConfigData("charcoal_pit_Enable")

local alternate_ingredient 			= "trinket_6"
local alternate_ingredient_2 		= "trinket_3"
local alternate_ingredient_cost 	= 2
local alternate_ingredient_2_cost 	= 2
	
if as_alternate_recipe == "true" then
	alternate_ingredient 			= "transistor"
	alternate_ingredient_2			= "rope"
	alternate_ingredient_cost 		= 6
	alternate_ingredient_2_cost 	= 8
end
	
local ice_chest_Disable 			= TECH.SCIENCE_TWO
local compost_box_Disable 			= TECH.SCIENCE_ONE
local crate_material_Disable 		= TECH.SCIENCE_TWO
local crate_wooden_Disable 			= TECH.SCIENCE_TWO
local crate_metal_Disable 			= TECH.SCIENCE_TWO
local trash_can_Disable 			= TECH.SCIENCE_ONE
local charcoal_pit_Disable 			= TECH.SCIENCE_ONE
	
if ice_chest_Enable == "false" then
	ice_chest_Disable				= TECH.LOST
end

if compost_box_Enable == "false" then
	compost_box_Disable				= TECH.LOST
end

if crate_material_Enable == "false" then
	crate_material_Disable			= TECH.LOST
end

if crate_wooden_Enable == "false" then
	crate_wooden_Disable			= TECH.LOST
end

if crate_metal_Enable == "false" then
	crate_metal_Disable				= TECH.LOST
end

if trash_can_Enable == "false" then
	trash_can_Disable				= TECH.LOST
end

if charcoal_pit_Enable == "false" then
	charcoal_pit_Disable				= TECH.LOST
end

if GLOBAL.IsDLCEnabled(GLOBAL.CAPY_DLC) or GLOBAL.IsDLCEnabled(GLOBAL.PORKLAND_DLC) then
	local ice_chest = Recipe("ice_chest", 
	{
		Ingredient("cutstone", 						2), 
		Ingredient("gears", 						2), 
		Ingredient(alternate_ingredient, 			alternate_ingredient_cost)
	}, 
	RECIPETABS.FARM, ice_chest_Disable, GLOBAL.RECIPE_GAME_TYPE.COMMON, "ice_chest_placer" )	

	local compost_box = Recipe("compost_box", 
	{
			Ingredient("spoiled_food", 				20), 
			Ingredient("boards", 					2)
	}, 
	RECIPETABS.FARM, compost_box_Disable, GLOBAL.RECIPE_GAME_TYPE.COMMON, "compost_box_placer" )

	local crate_material = Recipe("crate_material", 
	{
			Ingredient("boards", 					2), 
			Ingredient(alternate_ingredient_2, 		alternate_ingredient_2_cost), 
			Ingredient("shovel", 					1)
	},  
	RECIPETABS.TOWN, crate_material_Disable, GLOBAL.RECIPE_GAME_TYPE.COMMON,  "crate_material_placer" )

	local crate_wooden = Recipe("crate_wooden", 
	{
		Ingredient("boards", 						6), 
		Ingredient("rope", 							2)
	}, 
	RECIPETABS.TOWN, crate_wooden_Disable, GLOBAL.RECIPE_GAME_TYPE.COMMON, "crate_wooden_placer" )

	local crate_metal = Recipe("crate_metal", 
	{
		Ingredient("cutstone", 						1), 
		Ingredient("gears", 						1), 
		Ingredient(alternate_ingredient, 			alternate_ingredient_cost)
	}, 
	RECIPETABS.TOWN, crate_metal_Disable, GLOBAL.RECIPE_GAME_TYPE.COMMON, "crate_metal_placer" )

	local trash_can = Recipe("trash_can", 
	{
		Ingredient("cutstone", 						4)
	}, 
	RECIPETABS.TOWN, trash_can_Disable, GLOBAL.RECIPE_GAME_TYPE.COMMON, "trash_can_placer" )
	
	local charcoal_pit = Recipe("charcoal_pit", 
	{
		Ingredient("cutstone", 						2),
		Ingredient("charcoal", 						8),
		Ingredient("rocks", 						12)
	}, 
	RECIPETABS.TOWN, charcoal_pit_Disable, GLOBAL.RECIPE_GAME_TYPE.COMMON, "charcoal_pit_placer" )
	
	ice_chest.atlas 		= "images/inventoryimages/ice_chest.xml"
	compost_box.atlas 		= "images/inventoryimages/compost_box.xml"
	crate_material.atlas 	= "images/inventoryimages/crate_material.xml"
	crate_wooden.atlas 		= "images/inventoryimages/crate_wooden.xml"
	crate_metal.atlas 		= "images/inventoryimages/crate_metal.xml"
	trash_can.atlas			= "images/inventoryimages/trash_can.xml"
	charcoal_pit.atlas			= "images/inventoryimages/charcoal_pit.xml"

	AddMinimapAtlas("images/inventoryimages/ice_chest.xml")
	AddMinimapAtlas("images/inventoryimages/compost_box.xml")
	AddMinimapAtlas("images/inventoryimages/crate_material.xml")
	AddMinimapAtlas("images/inventoryimages/crate_wooden.xml")
	AddMinimapAtlas("images/inventoryimages/crate_metal.xml")
	AddMinimapAtlas("images/inventoryimages/trash_can.xml")	
	AddMinimapAtlas("images/inventoryimages/charcoal_pit.xml")	
else
	local ice_chest = Recipe("ice_chest", 
	{
		Ingredient("cutstone", 						2), 
		Ingredient("gears", 						2), 
		Ingredient(alternate_ingredient, 			alternate_ingredient_cost)
	}, 
	RECIPETABS.FARM, ice_chest_Disable, "ice_chest_placer" )	

	local compost_box = Recipe("compost_box", 
	{
			Ingredient("spoiled_food", 				20), 
			Ingredient("boards", 					2)
	}, 
	RECIPETABS.FARM, compost_box_Disable, "compost_box_placer" )

	local crate_material = Recipe("crate_material", 
	{
			Ingredient("boards", 					2), 
			Ingredient(alternate_ingredient_2, 		alternate_ingredient_2_cost), 
			Ingredient("shovel", 					1)
	},  
	RECIPETABS.TOWN, crate_material_Disable,  "crate_material_placer" )

	local crate_wooden = Recipe("crate_wooden", 
	{
		Ingredient("boards", 						6), 
		Ingredient("rope", 							2)
	}, 
	RECIPETABS.TOWN, crate_wooden_Disable, "crate_wooden_placer" )

	local crate_metal = Recipe("crate_metal", 
	{
		Ingredient("cutstone", 						1), 
		Ingredient("gears", 						1), 
		Ingredient(alternate_ingredient, 			alternate_ingredient_cost)
	}, 
	RECIPETABS.TOWN, crate_metal_Disable, "crate_metal_placer" )

	local trash_can = Recipe("trash_can", 
	{
		Ingredient("cutstone", 						4)
	}, 
	RECIPETABS.TOWN, trash_can_Disable, "trash_can_placer" )
	
	local charcoal_pit = Recipe("charcoal_pit", 
	{
		Ingredient("cutstone", 						2),
		Ingredient("charcoal", 						8),
		Ingredient("rocks", 						12)
	}, 
	RECIPETABS.TOWN, charcoal_pit_Disable, "charcoal_pit_placer" )
	
	ice_chest.atlas 		= "images/inventoryimages/ice_chest.xml"
	compost_box.atlas 		= "images/inventoryimages/compost_box.xml"
	crate_material.atlas 	= "images/inventoryimages/crate_material.xml"
	crate_wooden.atlas 		= "images/inventoryimages/crate_wooden.xml"
	crate_metal.atlas 		= "images/inventoryimages/crate_metal.xml"
	trash_can.atlas			= "images/inventoryimages/trash_can.xml"
	charcoal_pit.atlas			= "images/inventoryimages/charcoal_pit.xml"

	AddMinimapAtlas("images/inventoryimages/ice_chest.xml")
	AddMinimapAtlas("images/inventoryimages/compost_box.xml")
	AddMinimapAtlas("images/inventoryimages/crate_material.xml")
	AddMinimapAtlas("images/inventoryimages/crate_wooden.xml")
	AddMinimapAtlas("images/inventoryimages/crate_metal.xml")
	AddMinimapAtlas("images/inventoryimages/trash_can.xml")	
	AddMinimapAtlas("images/inventoryimages/charcoal_pit.xml")	
end
