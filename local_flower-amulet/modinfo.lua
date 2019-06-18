name = "Flower Amulet"
author = "krylincy"
version = "1.1"
description = [[With the Flower Amulet you can plant 
seeds everywhere. 

Will you discover the other traits?

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
		name = "DURABILITY",
		label = "Durability:",
		options = {
			{description = "infinity", data = 0},
			{description = "8 min", data = 1},
		},
		default = 1,
	}
}