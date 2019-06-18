name = "Ice Backpack"
description = ""
author = "krylincy"
version = "1.1"

description = [[Craftable Krampus Sack. Optional with freezing/cooling function.

]]..version

forumthread = ""

api_version = 6

icon = "icon.tex"
icon_atlas = "icon.xml"

dont_starve_compatible = true
reign_of_giants_compatible = true
shipwrecked_compatible = true
porkland_compatable = true

configuration_options = {
	{
		name = "FRIDGE_FUNCTION",
		label = "Food spoilage:",
		options = {
			{description = "default backpack", data = 1},
			{description = "ice backpack", data = 2},
			{description = "ice box", data = 3}
		},
		default = 1,
	},{
		name = "machine",
		label = "Crafting Tier:",
		options = {
			{description = "-", data = 0},
			{description = "Science Machine", data = 1},
			{description = "Alchemy Engine", data = 2},
			{description = "Prestihatitator", data = 3},
			{description = "Shadow Manipulator", data = 4},
			{description = "Ancient Pseudoscience Station", data = 5}
		},
		default = 1,
	},{
		name = "RECIPE_TYPE_CUTREEDS",
		label = "Cut Reeds",
		options = {
			{description = "-", data = 0},
			{description = "1", data = 1},
			{description = "5", data = 5},
			{description = "10", data = 10},
			{description = "15", data = 15},
			{description = "20", data = 20},
			{description = "25", data = 25},
			{description = "30", data = 30},
			{description = "35", data = 35},
			{description = "40", data = 40}
		},
		default = 5,
	},{
		name = "RECIPE_TYPE_PAPYRUS",
		label = "Papyrus",
		options = {
			{description = "-", data = 0},
			{description = "1", data = 1},
			{description = "5", data = 5},
			{description = "10", data = 10},
			{description = "15", data = 15},
			{description = "20", data = 20},
			{description = "25", data = 25},
			{description = "30", data = 30},
			{description = "35", data = 35},
			{description = "40", data = 40}
		},
		default = 0,
	},{
		name = "RECIPE_TYPE_ROPE",
		label = "Rope",
		options = {
			{description = "-", data = 0},
			{description = "1", data = 1},
			{description = "5", data = 5},
			{description = "10", data = 10},
			{description = "15", data = 15},
			{description = "20", data = 20},
			{description = "25", data = 25},
			{description = "30", data = 30},
			{description = "35", data = 35},
			{description = "40", data = 40}
		},
		default = 5,
	},{
		name = "RECIPE_TYPE_GOLDNUGGET",
		label = "Goldnugget",
		options = {
			{description = "-", data = 0},
			{description = "1", data = 1},
			{description = "5", data = 5},
			{description = "10", data = 10},
			{description = "15", data = 15},
			{description = "20", data = 20},
			{description = "25", data = 25},
			{description = "30", data = 30},
			{description = "35", data = 35},
			{description = "40", data = 40}
		},
		default = 0,
	},{
		name = "RECIPE_TYPE_BEARGER_FUR",
		label = "Thick Fur",
		options = {
			{description = "-", data = 0},
			{description = "1", data = 1},
			{description = "2", data = 2},
			{description = "3", data = 3}
		},
		default = 0,
	},{
		name = "RECIPE_TYPE_DRAGON_SCALES",
		label = "Scales",
		options = {
			{description = "-", data = 0},
			{description = "1", data = 1},
			{description = "2", data = 2},
			{description = "3", data = 3}
		},
		default = 0,
	},{
		name = "RECIPE_TYPE_CHARCOAL",
		label = "Charcoal",
		options = {
			{description = "-", data = 0},
			{description = "1", data = 1},
			{description = "5", data = 5},
			{description = "10", data = 10},
			{description = "15", data = 15},
			{description = "20", data = 20},
			{description = "25", data = 25},
			{description = "30", data = 30},
			{description = "35", data = 35},
			{description = "40", data = 40}
		},
		default = 20,
	}
}
