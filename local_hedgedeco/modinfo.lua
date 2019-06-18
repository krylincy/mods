name = "Hedge Decoration"
author = "krylincy"
version = "1.1"
description = [[The hamlet hedge and lawn decorations
can be craftet from the city planning tab.

]]..version

forumthread = ""

api_version = 6

icon = "preview.tex"
icon_atlas = "preview.xml"

dont_starve_compatible = true
reign_of_giants_compatible = true
shipwrecked_compatible = true
porkland_compatable = true

configuration_options = {
	{
		name = "WORKABLE_HEDGES",
		label = "Hedges removable:",
		options = {
			{description = "game default", data = false},
			{description = "with hammer", data = true},
		},
		default = true,
	},{
		name = "OINCS_HEDGES",
		label = "Hedges cost:",
		options = {
			{description = "1 Oinc", data = 1},
			{description = "2 Oinc", data = 2},
			{description = "3 Oinc", data = 3},
			{description = "4 Oinc", data = 4},
			{description = "5 Oinc", data = 5},
			{description = "8 Oinc", data = 8},
			{description = "10 Oinc", data = 10},
			{description = "15 Oinc", data = 15},
			{description = "20 Oinc", data = 20},
		},
		default = 3,
	},	{
		name = "WORKABLE_LAWNORNAMENT",
		label = "Lawnornament removable:",
		options = {
			{description = "game default", data = false},
			{description = "with hammer", data = true},
		},
		default = true,
	},{
		name = "OINCS_LAWNORNAMENT",
		label = "Lawnornament cost:",
		options = {
			{description = "1 Oinc", data = 1},
			{description = "2 Oinc", data = 2},
			{description = "3 Oinc", data = 3},
			{description = "4 Oinc", data = 4},
			{description = "5 Oinc", data = 5},
			{description = "8 Oinc", data = 8},
			{description = "10 Oinc", data = 10},
			{description = "15 Oinc", data = 15},
			{description = "20 Oinc", data = 20},
		},
		default = 3,
	},
}