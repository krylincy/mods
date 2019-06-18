GetPlayer = GLOBAL.GetPlayer
GetString = GLOBAL.GetString
GetClock = GLOBAL.GetClock

AddPrefabPostInit("deco_chaise", function(inst) 
	local function onsleep(inst, sleeper)
		if GetClock():IsDay() then
			local tosay = "ANNOUNCE_NODAYSLEEP"
	
			if sleeper.components.talker then
				sleeper.components.talker:Say(GetString(sleeper.prefab, tosay))
				return
			end
		end		

		if sleeper.components.hunger.current < TUNING.CALORIES_MED then
			sleeper.components.talker:Say(GetString(sleeper.prefab, "ANNOUNCE_NOHUNGERSLEEP"))
			return
		end
		
		sleeper.components.health:SetInvincible(true)
		sleeper.components.playercontroller:Enable(false)

		GetPlayer().HUD:Hide()
		TheFrontEnd:Fade(false,1)

		inst:DoTaskInTime(1.2, function() 
			
			GetPlayer().HUD:Show()
			TheFrontEnd:Fade(true,1) 
			
			if GetClock():IsDay() then

				local tosay = "ANNOUNCE_NODAYSLEEP"

				if sleeper.components.talker then				
					sleeper.components.talker:Say(GetString(sleeper.prefab, tosay))
					sleeper.components.health:SetInvincible(false)
					sleeper.components.playercontroller:Enable(true)
					return
				end
			end
			
			if sleeper.components.sanity then
				sleeper.components.sanity:DoDelta(TUNING.SANITY_HUGE)
			end
			
			if sleeper.components.hunger then
				sleeper.components.hunger:DoDelta(-TUNING.CALORIES_HUGE, false, true)
			end
			
			if sleeper.components.health then
				sleeper.components.health:DoDelta(TUNING.HEALING_HUGE, false, "tent", true)
			end
			
			if sleeper.components.temperature and sleeper.components.temperature.current < TUNING.TARGET_SLEEP_TEMP then
				sleeper.components.temperature:SetTemperature(TUNING.TARGET_SLEEP_TEMP)
			end		
			
			local moisture_start = nil
			if sleeper.components.moisture and sleeper.components.moisture:GetMoisture() > 0 then
				moisture_start = sleeper.components.moisture.moisture
			end

			GetClock():MakeNextDay()

			if moisture_start then
				sleeper.components.moisture.moisture = moisture_start - TUNING.SLEEP_MOISTURE_DELTA
				if sleeper.components.moisture.moisture < 0 then sleeper.components.moisture.moisture = 0 end
			end
			
			sleeper.components.health:SetInvincible(false)
			sleeper.components.playercontroller:Enable(true)
			sleeper.sg:GoToState("wakeup")	
		end)
	end
	
    inst:AddComponent("sleepingbag")
	inst.components.sleepingbag.onsleep = onsleep
end)
