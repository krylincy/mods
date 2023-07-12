local function StoneSlabPostInit(self)
	local function getregentimefn(inst)
		local time = TUNING.FLIPPABLE_ROCK_REPOPULATE_TIME + math.random()*TUNING.FLIPPABLE_ROCK_REPOPULATE_VARIANCE
		if inst.components.pickable then
			local num_cycles_deviation = TUNING.FLIPPABLE_ROCK_CYCLES - inst.components.pickable.cycles_left
--			print("num_cycles_deviation:", num_cycles_deviation)
			time = time + TUNING.FLIPPABLE_ROCK_REPOPULATE_INCREASE*num_cycles_deviation
		end
		return time
	end
	self.components.pickable.getregentimefn = getregentimefn

	local function getmaxcyclesfn(inst)
		return TUNING.FLIPPABLE_ROCK_CYCLES + math.random(2)
	end
	self.components.pickable.getmaxcyclesfn = getmaxcyclesfn
end
AddPrefabPostInit("rock_flippable", StoneSlabPostInit)
