TUNING = GLOBAL.TUNING

local function BerryBushPostInit(self)
	local function getregentimefn(inst)
		local time = TUNING.BERRY_REGROW_TIME + math.random()*TUNING.BERRY_REGROW_VARIANCE
		if inst.components.pickable then
			local num_cycles_deviation = TUNING.BERRYBUSH_CYCLES - inst.components.pickable.cycles_left
--			print("num_cycles_deviation:", num_cycles_deviation)
			time = time + TUNING.BERRY_REGROW_INCREASE*num_cycles_deviation
		end
		return time
	end
	self.components.pickable.getregentimefn = getregentimefn

	local function getmaxcyclesfn(inst)
		return TUNING.BERRYBUSH_CYCLES + math.random(2)
	end
	self.components.pickable.getmaxcyclesfn = getmaxcyclesfn
end
AddPrefabPostInit("berrybush", BerryBushPostInit)
AddPrefabPostInit("berrybush_snake", BerryBushPostInit)
AddPrefabPostInit("berrybush2", BerryBushPostInit)
AddPrefabPostInit("berrybush2_snake", BerryBushPostInit)
AddPrefabPostInit("coffeebush", BerryBushPostInit)
AddPrefabPostInit("elephantcactus", BerryBushPostInit)

local function CoffeeBushPostInit(self)
	self.components.pickable.wither_temp = math.random(TUNING.SW_MIN_PLANT_WITHER_TEMP, TUNING.SW_MAX_PLANT_WITHER_TEMP)
	self.components.pickable.rejuvenate_temp = math.random(TUNING.SW_MIN_PLANT_REJUVENATE_TEMP, TUNING.SW_MAX_PLANT_REJUVENATE_TEMP)
end
AddPrefabPostInit("coffeebush", CoffeeBushPostInit)
