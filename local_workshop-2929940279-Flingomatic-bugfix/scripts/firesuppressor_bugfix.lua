TUNING = GLOBAL.TUNING

--local YESTAGS = {"burnable"}
local YESTAGSES = {
	{"burnable"},
	{"witherable"},
	{"withered"},
}
local NOTAGS = {"FX", "DECOR", "INLIMBO", "flingomatic_freeze_immune"} -- "NOCLICK",

local function HitPlants(inst, dist, noextinguish)
	local protector = inst.owner or inst

	dist = dist or 4

	local x,y,z = inst:GetPosition():Get()

--	local ents = GLOBAL.TheSim:FindEntities(x,y,z, dist, YESTAGS, NOTAGS)
	local ents = {}
	for k, yestags in pairs(YESTAGSES) do
		ents1 = GLOBAL.TheSim:FindEntities(x,y,z, dist, yestags, NOTAGS)
		for k1, ent in pairs(ents1) do
			ents[ent] = ent
		end
	end

	for k,v in pairs(ents) do
		if v then
			-- print("CHECK CHECK",v.prefab)
-- If the plant loses makewitherabletask, it will no longer be given the "witherable" tag.
--[[
			if v.makewitherabletask then
				v.makewitherabletask:Cancel()
				v.makewitherabletask = nil
			end
]]
			local pickable = v.components.crop or v.components.pickable or v.components.hackable
			if pickable and (v.makewitherabletask or v.removeprotecttask or pickable.witherable) then
				pickable.protected = true
				v:AddTag("protected")
				table.insert(protector.protected_plants, v)
--[[
				local found = false
				for index ,plant in pairs(protector.protected_plants) do
					if plant == v then
						found = true
					end
				end
				if not found then
					table.insert(protector.protected_plants, v)
				end
]]
--				if v.components.crop == nil then	-- pickable or hackable
				if v.components.pickable or v.components.hackable then
					-- This plant is already protected. "witherable" tag will not cause the plant to wither unless the fire suppressor is scrapped.
					-- Therefore, it is possible to add a "witherable" tag immediately.
					if v.makewitherabletask then
						v.makewitherabletask:Cancel()
						v.makewitherabletask = nil
						-- This is already protected.
						pickable.witherable = true
						v:AddTag("witherable")
					end
					if v.removeprotecttask then
						v.removeprotecttask:Cancel()
						v.removeprotecttask = nil
					end

					if pickable.withered or pickable.shouldwither then
						if pickable.cycles_left and pickable.cycles_left <= 0 then
							pickable:MakeBarren()
						else
							pickable:MakeEmpty()
						end
						pickable.withered = false
						pickable.shouldwither = false
						v:RemoveTag("withered")
					end
					v.UnprotectPlant = function(v)
						protector:UnprotectPlant(v)
					end
					protector:ListenForEvent(v.components.pickable and "picked" or "hacked", v.UnprotectPlant, v)
				end
			end

			if not noextinguish then
--				print("testing",v.prefab)
				if v.components.burnable then
--					print("testing 2",v.prefab)
					if v.components.burnable:IsBurning() then
--						print("testing 3",v.prefab)
						v.components.burnable:Extinguish(true, TUNING.FIRESUPPRESSOR_EXTINGUISH_HEAT_PERCENT)
					elseif v.components.burnable:IsSmoldering() then
--						print("testing 4",v.prefab)
						v.components.burnable:Extinguish(true)
					end
				end
				if v.components.freezable then
--					print("testing 5",v.prefab)
					v.components.freezable:AddColdness(2) 
				end
				if v.components.temperature then
--					print("testing 6",v.prefab)
					local temp = v.components.temperature:GetCurrent()
					v.components.temperature:SetTemperature(temp - TUNING.FIRE_SUPPRESSOR_TEMP_REDUCTION)
				end
			end
		end
	end
end

local function FireSuppressorPostInit(self)
	local origin_LaunchProjectile = self.LaunchProjectile
	local function LaunchProjectile(inst, targetpos)
		origin_LaunchProjectile(inst, targetpos)
		if inst.components.firedetector and inst.components.firedetector.detectedItems then
			for k,v in pairs(inst.components.firedetector.detectedItems) do
				if v:GetPosition() == targetpos then
					inst.components.firedetector:AddShootedItem(v)
					inst.components.firedetector.detectedItems[v] = nil
					break
				end
			end
		end
	end
	self.LaunchProjectile = LaunchProjectile

	local function AddRemoveProtectTask(inst)
--		inst:RemoveTag("protected")
--		inst.components.pickable.protected = false
		if inst.removeprotecttask == nil then
			local variance = (math.random() - 0.5) * TUNING.WITHER_BUFFER_TIME
			inst.removeprotecttask = inst:DoTaskInTime(TUNING.WITHER_BUFFER_TIME + variance, function(inst) 
				local pickable = inst.components.crop or inst.components.pickable or inst.components.hackable
				pickable.protected = false
				inst:RemoveTag("protected")
				-- You should remove this plant from inst.protected_plants here.
				-- But I don't know to get the instance of fire suppressor(protector) here.
--[[
				for k, v in pairs(protector.protected_plants) do
					if v == inst then
						table.remove(protector.protected_plants, k)
						break
					end
				end
]]
				if inst.removeprotecttask then
					inst.removeprotecttask:Cancel()
					inst.removeprotecttask = nil
				end
			end)
		end
	end

	local function UnprotectPlant(inst, plant)
		if plant and #inst.protected_plants > 0 then
			local pickable = plant.components.pickable or plant.components.hackable
			if pickable == nil then
				-- print("This protected plant must be pickable or hackable!!")
				return
			end
			for k,v in ipairs(inst.protected_plants) do
				if v and v == plant then
--					inst:RemoveEventCallback("picked", v.UnprotectPlant, v)
					inst:RemoveEventCallback(v.components.pickable and "picked" or "hacked", v.UnprotectPlant, v)
--					v:RemoveTag("protected")
--					v.components.pickable.protected = false
					AddRemoveProtectTask(v)
-- This is not necessary since the "witherable" tag is never removed by the fire suppressor.
--					v.makewitherabletask = v:DoTaskInTime(TUNING.WITHER_BUFFER_TIME, function(v) 
--						v.components.pickable:MakeWitherable()
--					end)
					break
				end
			end
		end
	end
	self.UnprotectPlant = UnprotectPlant

	local function onhammered(inst, worker)
		local function RemoveAllWitherProtection(inst)
			if #inst.protected_plants > 0 then
				for k,v in pairs(inst.protected_plants) do
					if v then
						local pickable = v.components.crop or v.components.pickable or v.components.hackable
						if pickable then
							AddRemoveProtectTask(v)
						end
					end
				end
			end
			inst.protected_plants = {}
		end

		if inst:HasTag("fire") and inst.components.burnable then
			inst.components.burnable:Extinguish()
		end
		inst.SoundEmitter:KillSound("idleloop")
		inst.components.lootdropper:DropLoot()
		GLOBAL.SpawnPrefab("collapse_small").Transform:SetPosition(inst.Transform:GetWorldPosition())
		inst.SoundEmitter:PlaySound("dontstarve/common/destroy_wood")

		RemoveAllWitherProtection(inst)

		inst:Remove()
	end
	self.components.workable:SetOnFinishCallback(onhammered)

	self.OnLoadPostPass = nil
end
AddPrefabPostInit("firesuppressor", FireSuppressorPostInit)

local function FireSuppressorProjectilePostInit(self)
	local function OnHit(inst, dist)
		inst.SoundEmitter:PlaySound("dontstarve_DLC001/common/firesupressor_impact")
		GLOBAL.SpawnPrefab("splash_snow_fx").Transform:SetPosition(inst:GetPosition():Get())
		HitPlants(inst)
		inst:Remove()
	end
	self.components.complexprojectile:SetOnHit(OnHit)
end
AddPrefabPostInit("firesuppressorprojectile", FireSuppressorProjectilePostInit)
