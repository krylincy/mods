name = "Ancient Tab"
version = "1.1"
author = "krylincy"

description = "Adds Ancient Tab to Shadow manipulator"
forumthread = ""

icon = "ancient-tab.tex"
icon_atlas = "ancient-tab.xml"

api_version = 6
dont_starve_compatible = true
reign_of_giants_compatible = true
shipwrecked_compatible = true
hamlet_compatible = true

priority = 10


configuration_options = {
	{
		name = "ADD_RECIPES",
		label = "Add recipes (SW):",
		options = {
			{description = "Yes", data = true},
			{description = "No", data = false},
		},
		default = false,
	}
}



