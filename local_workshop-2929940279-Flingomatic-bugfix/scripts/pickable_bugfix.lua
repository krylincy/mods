TUNING = GLOBAL.TUNING

local function PickablePostConstruct(self)
--	local origin_witherHandler = self.witherHandler
	self.witherHandler = function(it, data)
		local tempcheck = self.reverseseasons and (data.temp <= self.rejuvenate_temp) or (data.temp > self.wither_temp)

		if self.witherable and not self.withered and not self.protected and tempcheck and 
		  (self.protected_cycles == nil or self.protected_cycles < 1) then
			if not self:IsBarren() then	-- Already barren plants do not wither.
				self.withered = true
				self.inst:AddTag("withered")
				self.wither_time = GLOBAL.GetTime()
				self:MakeBarren()
			end
		end
	end

--	local origin_Pick = self.Pick
	self.Pick = function(self, picker, simulate)
		if self.canbepicked and self.caninteractwith then
			if self.transplanted then
				if self.cycles_left ~= nil then
					self.cycles_left = self.cycles_left - 1
				end
			end

			if self.protected_cycles then
				self.protected_cycles = self.protected_cycles - 1
				if self.protected_cycles < 1 then
					self.protected_cycles = nil
				end
			end

			local loot = nil
			if not simulate then
				if picker and picker.components.inventory and self.product then
					loot = GLOBAL.SpawnPrefab(self.product)

					if loot then
						if self.numtoharvest > 1 and loot.components.stackable then
							loot.components.stackable:SetStackSize(self.numtoharvest)
						end

						self.inst:ApplyInheritedMoisture(loot)

						picker:PushEvent("picksomething", {object = self.inst, loot= loot})
						picker.components.inventory:GiveItem(loot, nil, GLOBAL.Vector3(GLOBAL.TheSim:GetScreenPos(self.inst.Transform:GetWorldPosition())))
					end
				end
			end

			if self.onpickedfn then
				self.onpickedfn(self.inst, picker, loot)
			end

			self.canbepicked = false
			self.hasbeenpicked = true

			if not self.paused and not self.withered and self.baseregentime and (self.cycles_left == nil or self.cycles_left > 0) and self.inst:IsValid() then
--				self.regentime = self.baseregentime * self:GetGrowthMod()
				local time = (self.getregentimefn and self.getregentimefn(self.inst) or self.baseregentime) * self:GetGrowthMod()	-- self.regentime is not needed because it is not referenced from anywhere.
--				self.task = self.inst:DoTaskInTime(self.regentime, OnRegen, "regen")
				self.task = self.inst:DoTaskInTime(time, function() self.inst.components.pickable:Regen() end, "regen")	-- Because OnRegen is local function.
--				self.targettime = GLOBAL.GetTime() + self.regentime
				self.targettime = GLOBAL.GetTime() + time
			end

			if not simulate then
				self.inst:PushEvent("picked", {picker = picker, loot = loot, plant = self.inst})
			end
		end

--		print(self:GetDebugString())
	end

--	local origin_SimulatePick = self.SimulatePick
	self.SimulatePick = function(self, picker)
		self:Pick(picker, true)
	end

	if not self.GetGrowthMod then	-- RoG DLC has no GetGrowthMod function.
		self.GetGrowthMod = function(self)
			local sm = GLOBAL.GetSeasonManager()
			if sm and sm:IsSpring() then
				return TUNING.SPRING_GROWTH_MODIFIER
			end
			return 1.0
		end
	end

--	local origin_Fertilize = self.Fertilize
	self.Fertilize = function(self, fertilizer, doer)
		if fertilizer.components.finiteuses then
			fertilizer.components.finiteuses:Use()
		else
			fertilizer.components.stackable:Get(1):Remove()
		end

		if self.inst.components.burnable and self.inst.components.burnable:IsSmoldering() then
			self.inst.components.burnable:StopSmoldering()
			return	-- only one benefit
		end

		self.protected_cycles = (self.protected_cycles or 0) + fertilizer.components.fertilizer.withered_cycles
		if self.protected_cycles >= 1 then
--			if self.withered or self.shouldwither then
			if self.withered then
--				self:Rejuvenate(fertilizer)	-- You don't need Rejuvenate() function anymore because it is only used here.
				self.withered = false
				self.inst:RemoveTag("withered")
			end

			local max_cycles = self.inst.components.pickable.getmaxcyclesfn and self.inst.components.pickable.getmaxcyclesfn(self.inst) or self.inst.components.pickable.max_cycles
			if max_cycles == nil then
				-- unwitherable plants (e.g. flowers) are protected until the end of this season.
				self.witherable = false	-- protect from withering until next season
				self.inst:RemoveTag("witherable")
				self.shouldwither = true	-- make witherable in next season
			end

			if self.inst.components.pickable and self.inst.components.pickable.getmaxcyclesfn then
				self.max_cycles = self.inst.components.pickable.getmaxcyclesfn(self.inst)
			end
			self.cycles_left = self.max_cycles
			self:MakeEmpty()
		else
			doer:PushEvent("insufficientfertilizer")
		end

--		print(self:GetDebugString())
	end

--	local origin_Rejuvenate = self.Rejuvenate
	self.Rejuvenate = nil

	self.GetDebugString = function(self)
		local time = GLOBAL.GetTime()

		local str = ""
		if self.paused then
			str = "paused"
			if self.pause_time then
				str = str.. string.format(" %2.2f", self.pause_time)
			end
		elseif not self.transplanted then
			str = "Not transplanted"
		end

		str = str.." cycles:" .. tostring(self.cycles_left) .. " / " .. tostring(self.max_cycles)
		if self.targettime and self.targettime > time then
			str = str.." Regen in:" ..  tostring(math.floor(self.targettime - time))
		end

		if self.protected_cycles and self.protected_cycles > 0 then
			str = str.." protected_cycles:" .. tostring(self.protected_cycles)
		end

		if self.protected then
			str = str.." protected"
		end

--		if self.caninteractwith then
--			str = str.." caninteractwith"
--		end

		if self.canbepicked then
			str = str.." canbepicked"
		end

		if self.hasbeenpicked then
			str = str.." hasbeenpicked"
		end

		if self.withered then
			str = str.." withered"
		end

		if self.witherable then
			str = str.." witherable"
		end

		if self.shouldwither then
			str = str.." shouldwither"
		end

		str = str .. "\n || withertemp: " .. self.wither_temp .. " rejuvtemp: " .. self.rejuvenate_temp

		return str
	end
end
AddClassPostConstruct("components/pickable", PickablePostConstruct)
