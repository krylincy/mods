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
			{description = "About 1 per Day", data = 1},
			{description = "About 2 per Day", data = 2},
			{description = "About 3 per Day", data = 3},
			{description = "About 4 per Day", data = 4},
			{description = "About 5 per Day", data = 5},
			{description = "About 6 per Day", data = 6},
			{description = "About 7 per Day", data = 7},
			{description = "About 8 per Day", data = 8},
		},
		default = 4,
	}, {
		name = "DOYDOYPET_DIE_OLD_AGE",
		label = "Die of old age:",
		options = {
			{description = "Very Fast", data = 1},
			{description = "Fast", data = 2},
			{description = "Medium", data = 3},
			{description = "Slow", data = 5},
			{description = "Very Slow", data = 10},
		},
		default = 3,
	}, {
		name = "DOYDOYPET_SEE_FOOD_DIST",
		label = "See food/walk distance:",
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
			{description = "40", data = 40},
			{description = "50", data = 50},
			{description = "60", data = 60},
		},
		default = 10,
	}, 
}
