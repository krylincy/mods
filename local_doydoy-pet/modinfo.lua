name = "Doydoy Pet"
version = "1"
author = "krylincy"

description = "A tamed Doydoy to run your own farm."
forumthread = ""

icon = "doydoypet-icon.tex"
icon_atlas = "doydoypet-icon.xml"

api_version = 6
dont_starve_compatible = true
reign_of_giants_compatible = true
shipwrecked_compatible = true
hamlet_compatible = true

priority=-1

configuration_options = {
	{
		name = "DOYDOYPET_EAT_INVERVALL",
		label = "Feeding time:",
		options = {
			{description = "About 1 per Day", data = 2},
			{description = "About 2 per Day", data = 3},
			{description = "About 3 per Day", data = 4},
			{description = "About 4 per Day", data = 5},
			{description = "About 5 per Day", data = 6},
			{description = "About 6 per Day", data = 7},
			{description = "About 7 per Day", data = 8},
			{description = "About 8 per Day", data = 9},
		},
		default = 5,
	},
	{
		name = "DOYDOYPET_BREED_CHANCE",
		label = "Chance for a Baby:",
		options = {
			{description = "10%", data = 0.1},
			{description = "20%", data = 0.2},
			{description = "30%", data = 0.3},
			{description = "40%", data = 0.4},
			{description = "50%", data = 0.5},
			{description = "60%", data = 0.6},
			{description = "70%", data = 0.7},
			{description = "80%", data = 0.8},
			{description = "90%", data = 0.9},
			{description = "100%", data = 1},
		},
		default = 0.8,
	},{
		name = "DOYDOYPET_FEMALE_CHANCE",
		label = "Female Baby:",
		options = {
			{description = "10%", data = 0.1},
			{description = "15%", data = 0.15},
			{description = "20%", data = 0.2},
			{description = "25%", data = 0.25},
			{description = "30%", data = 0.3},
			{description = "35%", data = 0.35},
			{description = "40%", data = 0.4},
			{description = "45%", data = 0.45},
			{description = "50%", data = 0.5},
			{description = "60%", data = 0.6},
			{description = "70%", data = 0.7},
			{description = "80%", data = 0.8},
			{description = "90%", data = 0.9},
		},
		default = 0.2,
	}, {
		name = "DOYDOYPET_DIE_OLD_AGE",
		label = "Die of old age:",
		options = {
			{description = "Very Fast", data = 3},
			{description = "Fast", data = 4}, 
			{description = "Medium", data = 5},
			{description = "Slow", data = 7},
			{description = "Very Slow", data = 10},
		},
		default = 3,
	}, {
		name = "DOYDOYPET_SEE_FOOD_DIST",
		label = "See food distance:",
		options = {
			{description = "1", data = 1},
			{description = "2", data = 2},
			{description = "3", data = 3},
			{description = "4", data = 4},
			{description = "5", data = 5},
			{description = "6", data = 6},
			{description = "7", data = 7},
			{description = "8", data = 8},
			{description = "9", data = 9},
			{description = "10", data = 10},
			{description = "15", data = 15},
			{description = "20", data = 20},
			{description = "25", data = 25},
			{description = "30", data = 30},
		},
		default = 8,
	}, 
}
