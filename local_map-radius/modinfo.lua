name = "Map reveal radius"
description = ""
author = "krylincy"
version = "1.1"

description = [[Change the map reveal radius.

Version: ]]..version
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
		name = "MAP_RADIUS",
		label = "Map reveal radius",
		options =	{
                        {description = "50%", data = 0.5},
                        {description = "75%", data = 0.75},
                        {description = "100%", data = 1},
                        {description = "150%", data = 1.5},
                        {description = "200%", data = 2},
                        {description = "250%", data = 2.5},
                        {description = "300%", data = 3},
                        {description = "350%", data = 3.5},
                        {description = "400%", data = 4},
                        {description = "450%", data = 4.5},
                        {description = "500%", data = 5},
                        {description = "550%", data = 5.5},
                        {description = "600%", data = 6},
                        {description = "650%", data = 6.5},
                        {description = "700%", data = 7},
                        {description = "750%", data = 7.5},
                        {description = "800%", data = 8},
                        {description = "850%", data = 8.5},
                        {description = "900%", data = 9},
                        {description = "950%", data = 9.5},
                        {description = "1000%", data = 10},
						
					},

		default = "3",	
	},
}
