name 						= "Additional Structures local"
description 				= "local Adds a variety of structures to the base game"
author 						= "Silentine"
version 					= "1.7.1"
forumthread 				= ""
api_version 				= 6
priority 					= 4
dont_starve_compatible = true
reign_of_giants_compatible = true
shipwrecked_compatible = true
hamlet_compatible = true


icon_atlas 					= "modicon.xml"
icon 						= "modicon.tex"

configuration_options =
{
	{
        name 	= "as_alternate_recipe",
        label 	= "Alternate Recipes",
        options =
        {
			{description = "Yes", 				data = "true"},
			{description = "No (Default)", 		data = "false"},
		},
        default = "false",
    },
	{
        name 	= "ice_chest_Enable",
        label 	= "Ice Chest Recipe",
        options =
        {
			{description = "Enable (Default)", 	data = "true"},
			{description = "Disable", 			data = "false"},
		},
        default = "true",
    },
	{
        name 	= "compost_box_Enable",
        label 	= "Compost Box Recipe",
        options =
        {
			{description = "Enable (Default)", 	data = "true"},
			{description = "Disable", 			data = "false"},
		},
        default = "true",
    },
	{
        name 	= "crate_material_Enable",
        label 	= "Pitcrate Recipe",
        options =
        {
			{description = "Enable (Default)", 	data = "true"},
			{description = "Disable", 			data = "false"},
		},
        default = "true",
    },
	{
        name 	= "crate_wooden_Enable",
        label 	= "Wooden Crate Recipe",
        options =
        {
			{description = "Enable (Default)", 	data = "true"},
			{description = "Disable", 			data = "false"},
		},
        default = "true",
    },
		{
        name 	= "crate_metal_Enable",
        label 	= "Metal Crate Recipe",
        options =
        {
			{description = "Enable (Default)", 	data = "true"},
			{description = "Disable", 			data = "false"},
		},
        default = "true",
    },
		{
        name 	= "trash_can_Enable",
        label 	= "Trash Can Recipe",
        options =
        {
			{description = "Enable (Default)", 	data = "true"},
			{description = "Disable", 			data = "false"},
		},
        default = "true",
    },
		{
        name 	= "charcoal_pit_Enable",
        label 	= "Charcoal Pit Recipe",
        options =
        {
			{description = "Enable (Default)", 	data = "true"},
			{description = "Disable", 			data = "false"},
		},
        default = "true",
    }
}