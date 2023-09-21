name = "local Buff Timers"
author = "Leonidas IV"

version = "1.1.1"

description = "\nShows timers for active buffs!"

api_version = 6
forumthread = ""

dont_starve_compatible = false
reign_of_giants_compatible = true
shipwrecked_compatible = true
hamlet_compatible = true

icon_atlas = "icon/modicon.xml"
icon = "modicon.tex"

local configs = {
    {id = "LEFT_OFFSET",             label = "Left Margin",           default = 550},
    {id = "TOP_OFFSET",              label = "Top Margin",            default = 50},
    {id = "IMAGE_SIZE",              label = "Image Size",            default = 40},
    {id = "MARGIN",                  label = "Inner Margin",          default = 8 },
    {id = "FONT_SIZE_TIMELEFT",      label = "Time Left Font Size",   default = 24},
    {id = "FONT_SIZE_MOD",           label = "Text Font Size",        default = 20},
}

configuration_options = {}

for i=1, #configs do
    configuration_options[i] = {
        name = configs[i].id,
        label = configs[i].label,
        default = configs[i].default,
        options = {}
    }
end

for i=1, #configs do
    local count = 1
    for j=-100, 700 do 
        configuration_options[i].options[count] = {description=j, data=j}
        count = count + 1
    end
end

configuration_options[#configuration_options+1] = {
    name = "ALWAYS_SHOW_TIMER",
    label = "Always Show Timers",
    default = false,
    options = {
        {description="Yes", data=true },
        {description="No" , data=false},
    }
}

configs, count = nil, nil