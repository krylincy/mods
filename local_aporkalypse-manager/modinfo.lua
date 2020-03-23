name = "Aporkalypse Manager"
description = ""
author = "krylincy"
version = "1.2"

description = [[With a start and stop engine.

]]..version

forumthread = ""

api_version = 6

icon = "aporkalypse_manager.tex"
icon_atlas = "aporkalypse_manager.xml"

dont_starve_compatible = true
reign_of_giants_compatible = true
shipwrecked_compatible = true
hamlet_compatible = true

configuration_options = {
	{
		name = "REMOVE_AFTER_USE",
		label = "Remove after use",
		options = {
			{description = "No", data = false},
			{description = "Yes", data = true},
		},
		default = false,
	},
	{
		name = "WITH_FUNCTION",
		label = "With Function",
		options = {
			{description = "No", data = false},
			{description = "Yes", data = true},
		},
		default = true,
	},
	{
		name = "CHANGE_SANITY",
		label = "Sanity change per use",
		options = {
			{description = "-", data = 0},
			{description = "-10", data = -10},
			{description = "-15", data = -15},
			{description = "-20", data = -20},
			{description = "-25", data = -25},
			{description = "-30", data = -30},
			{description = "-35", data = -35},
			{description = "-40", data = -40},
			{description = "-50", data = -50},
			{description = "-60", data = -60},
			{description = "-80", data = -80},
			{description = "-100", data = -100},
			{description = "-130", data = -130},
			{description = "-160", data = -160},
		},
		default = 0,
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
		default = 10,
	},
	{
		name = "RECIPE_TYPE_NIGHTMAREFUEL",
		label = "Nightmarefuel",
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
		default = 15,
	},
	{
		name = "RECIPE_TYPE_PURPLEGEM",
		label = "Purple Gem",
		options = {
			{description = "-", data = 0},
			{description = "1", data = 1},
			{description = "3", data = 3},
			{description = "5", data = 5},
			{description = "8", data = 8},
			{description = "10", data = 10},
			{description = "15", data = 15},
			{description = "20", data = 20},
		},
		default = 10,
	},
}
