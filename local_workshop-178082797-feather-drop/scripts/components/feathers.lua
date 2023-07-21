local Feathers = Class(function(self, inst)
	self.inst = inst
	self.droptime = TUNING.FEATHER_DROP_TIME + math.random(10, 30)
	self.birdname = nil
	self.inst:DoPeriodicTask(self.droptime, function() self:DropFeather() end)
	
	local modname = KnownModIndex:GetModActualName("local Birdcage(Time Based)")
	local feathers = GetModConfigData("Amount Of Named Seeds", modname)
	if feathers ~= "default" then
		self.inst:ListenForEvent("trade", function(inst, data) self:MoreSeeds(data.item) end)
	end
end)

function Feathers:DropFeather()
	if not self.inst:IsAsleep() then
		if self.inst.components.occupiable:IsOccupied() then 
			if math.random() < .5 then
				local x,y,z = self.inst.Transform:GetWorldPosition()
				local nearbyfeathers = TheSim:FindEntities(x,y,z, 3, {"feather"})
		
				if #nearbyfeathers >= TUNING.FEATHERS_ON_GROUND then return end
		
				self.birdname = self.inst.components.occupiable.occupant.prefab
		
				if self.birdname == "parrot" then
					self.birdname = "robin"
				elseif self.birdname == "toucan" then
					self.birdname = "crow"
				elseif self.birdname == "seagull" or self.birdname == "seagull_water" or self.birdname == "kingfisher" or self.birdname == "parrot_blue" or self.birdname == "pigeon" then
					self.birdname = "robin_winter"
				end
		
				local feather = "feather_"..self.birdname
				self.inst.components.lootdropper:SpawnLootPrefab(feather)
			end
		else 
			return 
		end
	end
end

function Feathers:MoreSeeds(item)
	if math.random() < .5 then
		local seed_name = string.lower(item.prefab .. "_seeds")
		if Prefabs[seed_name] then
			local num_seeds = math.random(TUNING.SEEDS_AMOUNT_LOWER, TUNING.SEEDS_AMOUNT_UPPER)
				for k = 1, num_seeds do
					self.inst.components.lootdropper:SpawnLootPrefab(seed_name)
				end
		end
	end
end

return Feathers