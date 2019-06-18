
GLOBAL.require( 'debugkeys' ) --testing
GLOBAL.CHEATS_ENABLED = true --testing


local function custom_console( inst )

	GLOBAL.RunScript("consolecommands")
	
	inst:DoTaskInTime( 0.001, function()		
		GLOBAL.GetPlayer().components.builder:GiveAllRecipes() --testing
		GLOBAL.GetWorld().minimap.MiniMap:ShowArea(0,0,0,10000)
	end)

end

AddSimPostInit(custom_console)

