name = "Casket"
version = "1.7"
author = "krylincy"

description = "A small casket for your pocket."
forumthread = ""

api_version = 6
dont_starve_compatible = true
reign_of_giants_compatible = true
shipwrecked_compatible = true
hamlet_compatible = true

icon_atlas = "casket.xml"
icon = "casket.tex"

priority=-1

configuration_options = {
	{
		name = "machine",
		label = "Crafting Tier:",
		options = {
			{description = "-", data = 0},
			{description = "Prestihatitator", data = 2},
			{description = "Shadow Manipulator", data = 3}
		},
		default = 0,
	}, {
		name = "purplegem",
		label = "Recipe:",
		options = {
			{description = "-", data = 0},
			{description = "Purple Gem: 1", data = 1},
			{description = "Purple Gem: 2", data = 2},
			{description = "Purple Gem: 3", data = 3},
			{description = "Purple Gem: 4", data = 4},
			{description = "Purple Gem: 5", data = 5},
			{description = "Purple Gem: 6", data = 6},
			{description = "Purple Gem: 7", data = 7},
			{description = "Purple Gem: 8", data = 8},
		},
		default = 0,
	}, {
		name = "nightmarefuel",
		label = "Recipe:",
		options = {
			{description = "-", data = 0},
			{description = "Nightmare Fuel: 1", data = 1},
			{description = "Nightmare Fuel: 2", data = 2},
			{description = "Nightmare Fuel: 3", data = 3},
			{description = "Nightmare Fuel: 4", data = 4},
			{description = "Nightmare Fuel: 5", data = 5},
			{description = "Nightmare Fuel: 6", data = 6},
			{description = "Nightmare Fuel: 7", data = 7},
			{description = "Nightmare Fuel: 8", data = 8},
		},
		default = 0,
	}, {
		name = "livinglog",
		label = "Recipe:",
		options = {
			{description = "-", data = 0},
			{description = "Living Log: 1", data = 1},
			{description = "Living Log: 2", data = 2},
			{description = "Living Log: 3", data = 3},
			{description = "Living Log: 4", data = 4},
			{description = "Living Log: 5", data = 5},
			{description = "Living Log: 6", data = 6},
			{description = "Living Log: 7", data = 7},
			{description = "Living Log: 8", data = 8},
		},
		default = 0,
	}, {
		name = "goldnugget",
		label = "Recipe:",
		options = {
			{description = "Gold Nugget: 1", data = 1},
			{description = "Gold Nugget: 2", data = 2},
			{description = "Gold Nugget: 3", data = 3},
			{description = "Gold Nugget: 4", data = 4},
			{description = "Gold Nugget: 5", data = 5},
			{description = "Gold Nugget: 6", data = 6},
			{description = "Gold Nugget: 7", data = 7},
			{description = "Gold Nugget: 8", data = 8},
		},
		default = 5,
	},
}
