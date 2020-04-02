name = "Batch Production"
author = "krylincy"
version = "1.1"
description = [[Produce rope, boards, cutstone, papyrus, bandage and healingsalve in in a batch of 10.
The ingredients are scaled and to compensate your time savings it costs an additional gold nugget.

]]..version

forumthread = ""

api_version = 6

icon = "icon.tex"
icon_atlas = "icon.xml"

dont_starve_compatible = true
reign_of_giants_compatible = true
shipwrecked_compatible = true
hamlet_compatible = true

configuration_options = {
	{
		name = "goldnugget",
		label = "Recipe:",
		options = {
			{description = "Gold Nugget: 0", data = 0},
			{description = "Gold Nugget: 1", data = 1},
			{description = "Gold Nugget: 2", data = 2},
			{description = "Gold Nugget: 3", data = 3},
			{description = "Gold Nugget: 4", data = 4},
			{description = "Gold Nugget: 5", data = 5},
		},
		default = 1,
	},
}

