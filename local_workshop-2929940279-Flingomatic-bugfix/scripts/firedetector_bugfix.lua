TUNING = GLOBAL.TUNING

local function FireDetectorPostConstruct(self)
--	local origin_LookForFiresAndFirestarters = self.LookForFiresAndFirestarters
	self.LookForFiresAndFirestarters = function(self, it, data)
		local x,y,z = self.inst:GetPosition():Get()
		local priority = 1
		local ents = {}
		local noTag = self.NOTAGS
		while priority <= #self.YESTAGS and #ents == 0 do
--			ents = TheSim:FindEntities(x,y,z, self.range, self.YESTAGS[priority], self.NOTAGS)
			if self.YESTAGS[priority][1] == "witherable" then
				table.insert(noTag, "protected")
			end
			ents = TheSim:FindEntities(x,y,z, self.range, self.YESTAGS[priority], noTag)
			if #ents > 0 then
				local toRemove = {}
				for k,v in pairs(ents) do
					if self.detectedItems[v] then
						table.insert(toRemove, k)
					elseif self.shootedItems and self.shootedItems[v] then
						table.insert(toRemove, k)
					end
				end
--				toRemove = table.reverse(toRemove)
--				for k,v in pairs(toRemove) do
				for k=#toRemove, 1, -1 do
--					table.remove(ents, v)
					table.remove(ents, toRemove[k])
				end
				--dumptable(ents)
			end
			priority = priority + 1
		end
		if #ents > 0 then
			for k,v in pairs(ents) do
--				if v and (v.makewitherabletask or (v.components.pickable and v.components.pickable.witherable) or (v.components.crop and v.components.crop.witherable)) then
				if v then
					local hasDetected = false
					local pickable = v.components.crop or v.components.pickable or v.components.hackable
--					if pickable and (v.makewitherabletask or pickable.witherable) then
					if pickable and (v.makewitherabletask or v.removeprotecttask or pickable.witherable) then
--						if pickable.IsBarren == nil or not pickable:IsBarren() then	-- Already barren plants don't need to be protected from withering
							local found = false
							if self.inst.protected_plants then
								for i,j in pairs(self.inst.protected_plants) do
									if j == v then
--										found = true
										found = true and pickable.protected	-- Don't ignore the unprotected plant. firesuppressor.UnprotectPlant function misses to remove a protected plant from protected_plants[].
										break
									end
								end
							end
							if not found then
--								self:OnFindFire(v)
								self:AddDetectedItem(v)
								hasDetected = true
--								break	-- !!? Why does you need this?
							end
--						end
					end
					if not hasDetected then
						if v.components.burnable and (v.components.burnable:IsBurning() or v.components.burnable:IsSmoldering()) then
--							self:OnFindFire(v)
							self:AddDetectedItem(v)
--							break	-- !!? Why does you need this?
						end
					end
				end
			end
		end

		if self.detectedItems and self.onfindfire then
			for k,v in pairs(self.detectedItems) do
				self.onfindfire(self.inst, v:GetPosition())
				if self.inst.sg:HasStateTag("idle") then
					break;
				end
			end
		end
	end

--	local origin_OnFindFire = self.OnFindFire
	self.OnFindFire = function(self, fire)
		self:AddDetectedItem(fire)
		if self.onfindfire then
			self.onfindfire(self.inst, fire:GetPosition())
		end
	end

--	local origin_AddDetectedItem = self.AddDetectedItem
	self.AddDetectedItem = function(self, item)
		if self.detectedItems[item] then
			return
		end
		self.detectedItems[item] = item
		self.inst:DoTaskInTime(TUNING.SEG_TIME/3, function(inst) self.detectedItems[item] = nil end)
	end

	self.AddShootedItem = function(self, item)
		if self.shootedItems == nil then
			self.shootedItems = {}
		end
		if self.shootedItems[item] then
			return
		end
		self.shootedItems[item] = item
		self.inst:DoTaskInTime(TUNING.SEG_TIME/5, function(inst) self.shootedItems[item] = nil end)
	end
end
AddClassPostConstruct("components/firedetector", FireDetectorPostConstruct)
