local function SeaweedPostInit(self)
	local function getregentimefn(inst)
		return TUNING.SEAWEED_REGROW_TIME + math.random()*TUNING.SEAWEED_REGROW_VARIANCE
	end

	self.components.pickable.baseregentime = TUNING.SEAWEED_REGROW_TIME
	self.components.pickable.getregentimefn = getregentimefn
end
AddPrefabPostInit("seataro_planted", SeaweedPostInit)
AddPrefabPostInit("seaweed_planted", SeaweedPostInit)
