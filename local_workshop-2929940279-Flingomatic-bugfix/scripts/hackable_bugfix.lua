TUNING = GLOBAL.TUNING

local function HackablePostConstruct(self)
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

--	local origin_Hack = self.Hack
	self.Hack = function(self, hacker, numworks, shear_mult, from_shears)
		if self.canbehacked and self.caninteractwith then
			self.hacksleft = self.hacksleft - numworks
			--Check work left here and fire callback and early out if there's still more work to do
			 if self.onhackedfn then
				self.onhackedfn(self.inst, hacker, self.hacksleft, from_shears)
			end

			if self.hacksleft > 0 then
				return
			end

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
			shear_mult = shear_mult or 1

			if self.product then
				for i=1, shear_mult do
					if self.inst.components.lootdropper then 
						self.inst.components.lootdropper:SpawnLootPrefab(self.product)
					else
						loot = GLOBAL.SpawnPrefab(self.product)

						if loot then
							self.inst:ApplyInheritedMoisture(loot)
							--picker:PushEvent("picksomething", {object = self.inst, loot= loot})

							local pt = Point(self.inst.Transform:GetWorldPosition())
							loot.Transform:SetPosition(pt.x,pt.y,pt.z)

							local angle = math.random()*2*PI
							local speed = math.random()
							loot.Physics:SetVel(speed*math.cos(angle), GetRandomWithVariance(12, 3), speed*math.sin(angle))
							--picker.components.inventory:GiveItem(loot, nil, GLOBAL.Vector3(GLOBAL.TheSim:GetScreenPos(self.inst.Transform:GetWorldPosition())))
						end
					end 
				end
			end

			if self.repeat_hack_cycle then
				self.hacksleft = self.maxhacks
			else
				self.canbehacked = false
				self.inst:AddTag("stump")
				self.hasbeenhacked = true
			end

			if not self.paused and not self.withered and self.baseregentime and (self.cycles_left == nil or self.cycles_left > 0) and self.inst:IsValid() then
--				self.regentime = self.baseregentime * self:GetGrowthMod()
				local time = (self.getregentimefn and self.getregentimefn(self.inst) or self.baseregentime) * self:GetGrowthMod()	-- self.regentime is not needed because it is not referenced from anywhere.
--				self.task = self.inst:DoTaskInTime(self.regentime, OnHackableRegen, "regen")
				self.task = self.inst:DoTaskInTime(time, function() self.inst.components.hackable:Regen() end, "regen")	-- Because OnHackableRegen is local function.
--				self.targettime = GLOBAL.GetTime() + self.regentime
				self.targettime = GLOBAL.GetTime() + time
			end

			self.inst:PushEvent("hacked", {hacker = hacker, loot = loot, plant = self.inst})
		end

--		print(self:GetDebugString())
	end

--	local origin_Fertilize = self.Fertilize
	self.Fertilize = function(self, fertilizer)
		if fertilizer.components.finiteuses then
			fertilizer.components.finiteuses:Use()
		else
			fertilizer.components.stackable:Get(1):Remove()
		end

		if self.inst.components.burnable and self.inst.components.burnable:IsSmoldering() then
			self.inst.components.burnable:StopSmoldering()
			return	-- only one benefit
		end

		local doer = fertilizer.components.inventoryitem and fertilizer.components.inventoryitem:GetGrandOwner() or GLOBAL.GetPlayer()

		self.protected_cycles = (self.protected_cycles or 0) + fertilizer.components.fertilizer.withered_cycles
		if self.protected_cycles >= 1 then
--			if self.withered or self.shouldwither then
			if self.withered then
--				self:Rejuvenate(fertilizer)	-- You don't need Rejuvenate() function anymore because it is only used here.
				self.withered = false
				self.inst:RemoveTag("withered")
			end

			local max_cycles = self.inst.components.hackable.getmaxcyclesfn and self.inst.components.hackable.getmaxcyclesfn(self.inst) or self.inst.components.hackable.max_cycles
			if max_cycles == nil then
				-- unwitherable plants (e.g. flowers) are protected until the end of this season.
				self.witherable = false	-- protect from withering until next season
				self.inst:RemoveTag("witherable")
				self.shouldwither = true	-- make witherable in next season
			end

			if self.inst.components.hackable and self.inst.components.hackable.getmaxcyclesfn then
				self.max_cycles = self.inst.components.hackable.getmaxcyclesfn(self.inst)
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

		if self.canbehacked then
			str = str.." canbehacked"
		end

		if self.hasbeenhacked then
			str = str.." hasbeenhacked"
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
AddClassPostConstruct("components/hackable", HackablePostConstruct)
