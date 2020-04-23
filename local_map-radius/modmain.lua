
-- yeah, thats all the magic
local function custom( inst )
	GLOBAL.RunScript("consolecommands")
	
	inst:DoTaskInTime( 0.01, function()
		if GLOBAL.GetPlayer().components.farseer then --SW OR HAM dlc
			GLOBAL.GetPlayer().components.farseer:AddBonus("basic", GetModConfigData("MAP_RADIUS"))
		else
			GLOBAL:GetWorld().minimap.MiniMap:SetRevealRadiusMultiplier(GetModConfigData("MAP_RADIUS"))
		end		
	end)
	
end

AddSimPostInit(custom)
