TUNING = GLOBAL.TUNING

local function CropPostConstruct(self)
	self.GetDebugString = function(self)
		local time = GLOBAL.GetTime()

		local str = "[" .. tostring(self.product_prefab) .. "] "
		if self.matured then
			str = str .. "DONE"
		else
			str = str .. string.format("%2.2f%% (done in %2.2f)", self.growthpercent, (1 - self.growthpercent)/self.rate)
		end

		if self.protected_cycles and self.protected_cycles > 0 then
			str = str.." protected_cycles:" .. tostring(self.protected_cycles)
		end

		if self.protected then
			str = str.." protected"
		end

		if self.withered then
			str = str.." withered"
		end

		if self.witherable then
			str = str.." witherable"
		end

		if self.makewitherabletask then
			str = str.." makewitherabletask"
		end

		return str
	end
end
AddClassPostConstruct("components/crop", CropPostConstruct)
