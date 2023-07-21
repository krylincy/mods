name = "local Birdcage(Time Based)"
description = "When you put bird into a cage it will drop feathers"
author = "_Q_"
version = "2.0"

forumthread = ""

api_version = 6

dont_starve_compatible = true
reign_of_giants_compatible = true
shipwrecked_compatible = true

icon_atlas = "birdcage.xml"
icon = "birdcage.tex"

configuration_options =
{
    {
        name = "Feather Drop Time",
        options =
        {
			{description = "Rarer", data = "rarer"},
			{description = "Rare", data = "rare"},
            {description = "Less", data = "less"},
			{description = "Default", data = "default"},
			{description = "More", data = "more"},
			{description = "Many", data = "often"},
        },
        default = "default",
    },
	
	{
        name = "Feathers On Ground Limit",
        options =
        {
			{description = "Rare", data = "rare"},
            {description = "Less", data = "less"},
			{description = "Default", data = "default"},
			{description = "More", data = "more"},
			{description = "Many", data = "often"},
        },
        default = "default",
    },
	
	{
        name = "Amount Of Named Seeds",
        options =
        {  
			{description = "No Seeds", data = "default"},
			{description = "1 Seed", data = "one"},
			{description = "1 - 2 Seeds", data = "two"},
			{description = "2 - 3 Seeds", data = "three"},
			{description = "2 - 4 Seeds", data = "four"},
        },
        default = "default",
    }
}
