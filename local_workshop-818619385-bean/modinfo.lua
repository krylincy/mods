name = "Marble Bean"
description = "Brings the marble bean from DST and make marble renewable!"
author = "DrBLOOD"
version = "1.16"

forumthread = ""

api_version = 6

dont_starve_compatible = true
reign_of_giants_compatible = true
shipwrecked_compatible = true

icon_atlas = "marblebeanmodee.xml"
icon = "marblebeanmodee.tex"

priority = -1

configuration_options =
{
	{
		name = "marbleshrub_grow_time",
		label = "Grow Speed %",
        hover = "Set the marble Shrub grow time.",
		options =
		{
			{description = "10X", data = 10},
			{description = "20X", data = 5},
			{description = "25X", data = 4},
			{description = "33X", data = 3},
			{description = "50X", data = 2},
			{description = "75X", data = 1.5},
			{description = "100X", data = 1},
			{description = "200X", data = .5},
			{description = "300X", data = .33},
			{description = "400X", data = .25},
			{description = "1000X", data = .1},
		},
		default = 1,
	}
}