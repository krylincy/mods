name = "local Hounds, depths worms, bosses, volcano eruption, aporkalypse and BFB predictor" 

description = "Predict hounds, crocodogs, bats, depths worms and bosses attack, volcano eruption, aporkalypse, and BFB spawn"
author = "TLOBen"
version = "1.2.1"

api_version = 6

dont_starve_compatible = true
reign_of_giants_compatible = true
shipwrecked_compatible = true
hamlet_compatible = true

icon_atlas = "modicon.xml"
icon = "modicon.tex"

priority = 0

forumthread = ""
server_filter_tags = {}
configuration_options = {
	{
		name = "ENABLE_HOUNDS_PREDICTOR",
		label = "Hounds/crocodogs/bats predictor",
		hover = "Predict the next wave of hounds, crocodogs or bats.",
		options = {
			{
                description = "Enabled",
                data = true
            },
            {
                description = "Disabled",
                data = false
            },
		},
		default = true,
	},
	{
		name = "ENABLE_DEPTHS_WORMS_PREDICTOR",
		label = "Depths worms predictor",
		hover = "Predict the next attacks of depths worms in the caves or ruins.",
		options = {
			{
                description = "Enabled",
                data = true
            },
            {
                description = "Disabled",
                data = false
            },
		},
		default = true,
	},
	{
		name = "ENABLE_HASSLERS_PREDICTOR",
		label = "Boss predictor",
		hover = "Predict the next spawn of deerclops, goosemoose, dragonfly, bearger or sealnado.",
		options = {
			{
                description = "Enabled",
                data = true
            },
            {
                description = "Disabled",
                data = false
            },
		},
		default = true,
	},
	{
		name = "ENABLE_VOLCANO_PREDICTOR",
		label = "Volcano eruption predictor",
		hover = "Predict the next eruption of the volcano (for Shipwrecked DLC).",
		options = {
			{
                description = "Enabled",
                data = true
            },
            {
                description = "Disabled",
                data = false
            },
		},
		default = true,
	},
	{
		name = "ENABLE_APORKALYPSE_PREDICTOR",
		label = "Aporkalypse predictor",
		hover = "Predict the start of the aporkalypse (for Hamlet DLC).",
		options = {
			{
                description = "Enabled",
                data = true
            },
            {
                description = "Disabled",
                data = false
            },
		},
		default = true,
	},
	{
		name = "ENABLE_ROC_PREDICTOR",
		label = "BFB predictor",
		hover = "Predict the next spawn of the BFB (for Hamlet DLC).",
		options = {
			{
                description = "Enabled",
                data = true
            },
            {
                description = "Disabled",
                data = false
            },
		},
		default = true,
	}
}