RECIPETABS = GLOBAL.RECIPETABS
Recipe = GLOBAL.Recipe
RECIPE_GAME_TYPE = GLOBAL.RECIPE_GAME_TYPE
Ingredient = GLOBAL.Ingredient
TECH = GLOBAL.TECH

function addAncientTab()
    TUNING["PROTOTYPER_TREES"]["SHADOWMANIPULATOR"]["ANCIENT"] = 4    

	-- add recipes only if you play in shipwrecked without hamlet compatibility and activated the option in the mod configuration
	if GLOBAL.SaveGameIndex:GetCurrentMode() == "shipwrecked" and GLOBAL.IsDLCEnabled(GLOBAL.PORKLAND_DLC) == false and GetModConfigData("ADD_RECIPES") == true then
		-- changed only the game types from RECIPE_GAME_TYPE.VANILLA to RECIPE_GAME_TYPE.SHIPWRECKED
		Recipe("thulecite", {Ingredient("thulecite_pieces", 6)}, RECIPETABS.ANCIENT, TECH.ANCIENT_TWO, RECIPE_GAME_TYPE.SHIPWRECKED, nil, nil, true)
		Recipe("wall_ruins_item", {Ingredient("thulecite", 1)}, RECIPETABS.ANCIENT, TECH.ANCIENT_TWO, RECIPE_GAME_TYPE.SHIPWRECKED, nil, nil, true, 6)
		Recipe("nightmare_timepiece", {Ingredient("thulecite", 2), Ingredient("nightmarefuel", 2)}, RECIPETABS.ANCIENT, TECH.ANCIENT_TWO, RECIPE_GAME_TYPE.SHIPWRECKED, nil, nil, true)
		Recipe("orangeamulet", {Ingredient("thulecite", 2), Ingredient("nightmarefuel", 3),Ingredient("orangegem", 1)}, RECIPETABS.ANCIENT,  TECH.ANCIENT_FOUR, RECIPE_GAME_TYPE.SHIPWRECKED, nil, nil, true)
		Recipe("yellowamulet", {Ingredient("thulecite", 2), Ingredient("nightmarefuel", 3),Ingredient("yellowgem", 1)}, RECIPETABS.ANCIENT, TECH.ANCIENT_TWO, RECIPE_GAME_TYPE.SHIPWRECKED, nil, nil, true)
		Recipe("greenamulet", {Ingredient("thulecite", 2), Ingredient("nightmarefuel", 3),Ingredient("greengem", 1)}, RECIPETABS.ANCIENT,  TECH.ANCIENT_TWO, RECIPE_GAME_TYPE.SHIPWRECKED, nil, nil, true)
		Recipe("orangestaff", {Ingredient("nightmarefuel", 2), Ingredient("cane", 1), Ingredient("orangegem", 2)}, RECIPETABS.ANCIENT, TECH.ANCIENT_FOUR, RECIPE_GAME_TYPE.SHIPWRECKED, nil, nil, true)
		Recipe("yellowstaff", {Ingredient("nightmarefuel", 4), Ingredient("livinglog", 2), Ingredient("yellowgem", 2)}, RECIPETABS.ANCIENT, TECH.ANCIENT_TWO, RECIPE_GAME_TYPE.SHIPWRECKED, nil, nil, true)
		Recipe("greenstaff", {Ingredient("nightmarefuel", 4), Ingredient("livinglog", 2), Ingredient("greengem", 2)}, RECIPETABS.ANCIENT, TECH.ANCIENT_TWO, RECIPE_GAME_TYPE.SHIPWRECKED, nil, nil, true)
		Recipe("multitool_axe_pickaxe", {Ingredient("goldenaxe", 1),Ingredient("goldenpickaxe", 1), Ingredient("thulecite", 2)}, RECIPETABS.ANCIENT, TECH.ANCIENT_FOUR, RECIPE_GAME_TYPE.SHIPWRECKED, nil, nil, true)
		Recipe("ruinshat", {Ingredient("thulecite", 4), Ingredient("nightmarefuel", 4)}, RECIPETABS.ANCIENT, TECH.ANCIENT_FOUR, RECIPE_GAME_TYPE.SHIPWRECKED, nil, nil, true)
		Recipe("armorruins", {Ingredient("thulecite", 6), Ingredient("nightmarefuel", 4)}, RECIPETABS.ANCIENT, TECH.ANCIENT_FOUR, RECIPE_GAME_TYPE.SHIPWRECKED, nil, nil, true)
		Recipe("ruins_bat", {Ingredient("livinglog", 3), Ingredient("thulecite", 4), Ingredient("nightmarefuel", 4)}, RECIPETABS.ANCIENT, TECH.ANCIENT_FOUR, RECIPE_GAME_TYPE.SHIPWRECKED, nil, nil, true)
		Recipe("eyeturret_item", {Ingredient("deerclops_eyeball", 1), Ingredient("minotaurhorn", 1), Ingredient("thulecite", 5)}, RECIPETABS.ANCIENT, TECH.ANCIENT_FOUR, RECIPE_GAME_TYPE.SHIPWRECKED, nil, nil, true)
	end
end

AddGamePostInit(addAncientTab)
AddSimPostInit(addAncientTab)



