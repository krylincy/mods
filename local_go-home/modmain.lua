STRINGS = GLOBAL.STRINGS
RECIPETABS = GLOBAL.RECIPETABS
Recipe = GLOBAL.Recipe
Ingredient = GLOBAL.Ingredient
TECH = GLOBAL.TECH
ACTIONS = GLOBAL.ACTIONS

function goHome(inst) 

	local GetPlayer = GLOBAL.GetPlayer
	local GetWorld = GLOBAL.GetWorld
	local GetSeasonManager = GLOBAL.GetSeasonManager
	local TheSim = GLOBAL.TheSim
	local TheCamera = GLOBAL.TheCamera
	local Sleep = GLOBAL.Sleep
	local distsq = GLOBAL.distsq
	
	local function canteleport(inst, caster, target)
		return true
	end
	
	local function teleport_thread(inst, caster, teletarget, loctarget)
		local ground = GetWorld()
		local t_loc = loctarget:GetPosition()
		local teleportee = teletarget
		local pt = teleportee:GetPosition()
		
		if teleportee.components.locomotor then
			teleportee.components.locomotor:StopMoving()
		end

		if teleportee.components.health then
			teleportee.components.health:SetInvincible(true)
		end

		if TUNING.DO_SEA_DAMAGE_TO_BOAT and (teleportee.components.driver and teleportee.components.driver.vehicle and teleportee.components.driver.vehicle.components.boathealth) then
			teleportee.components.driver.vehicle.components.boathealth:SetInvincible(true)
		end
		
		teleportee:Hide()
		TheFrontEnd:Fade(false, 2)
		Sleep(3)
		
		if caster.components.sanity then
			caster.components.sanity:DoDelta(-TUNING.SANITY_HUGE)
		end
		
		if ground.components.seasonmanager then
			ground.components.seasonmanager:ForcePrecip()
		end

		teleportee.Transform:SetPosition(t_loc.x, 0, t_loc.z)

		local snapcam = true
		if loctarget then
			if TheCamera.interior or loctarget.interior then
				local interiorSpawner = GetWorld().components.interiorspawner
				interiorSpawner:PlayTransition(GetPlayer(), nil, loctarget.interior, loctarget)   
				snapcam = false
			end
		else
			-- we may have to transition outside if we're currently inside
			if TheCamera.interior and t_loc then
				local interiorSpawner = GetWorld().components.interiorspawner
				interiorSpawner:PlayTransition(GetPlayer(), nil, nil, t_loc)   
				snapcam = false
			end
		end

		if teleportee == GetPlayer() and snapcam then
			TheCamera:Snap()
			TheFrontEnd:DoFadeIn(1)
			Sleep(1)
		end
		
		teleportee:Show()
		if teleportee.components.health then
			teleportee.components.health:SetInvincible(false)
		end
		if TUNING.DO_SEA_DAMAGE_TO_BOAT and (teleportee.components.driver and teleportee.components.driver.vehicle and teleportee.components.driver.vehicle.components.boathealth) then
			teleportee.components.driver.vehicle.components.boathealth:SetInvincible(false)
		end

		if teleportee == GetPlayer() then
			teleportee.sg:GoToState("wakeup")
			teleportee.SoundEmitter:PlaySound("dontstarve/common/staffteleport")
		end
	end

	local function teleport_func(inst, target)
		local mindistance = 30
		local caster = inst.components.inventoryitem.owner
		local tar = caster
		local pt = tar:GetPosition()
		local ents = TheSim:FindEntities(pt.x,pt.y,pt.z, 50000, {"gohomebase"}, {"INLIMBO"})

		local targets = {}
		for k,v in pairs(ents) do
			local v_pt = v:GetPosition()
			if distsq(pt, v_pt) >= mindistance * mindistance then
			print('###coco debug: ')
			print(v)
			print(distsq(pt, v_pt))
				table.insert(targets, {base = v, distance = distsq(pt, v_pt)}) 
			end
		end			

		if #targets > 0 then
			--table.sort(targets, function(a,b) return (a.distance) < (b.distance) end)	
			--local targets[1]
			local selection = math.random( #targets )
			local targetselection = targets[selection]
			
			print(selection)
			inst.task = inst:StartThread(function() teleport_thread(inst, caster, tar, targetselection.base) end)
		else
			print('Keine ziele')
		end
		
	end

	inst:AddComponent("spellcaster")
    inst.components.spellcaster:SetSpellFn(teleport_func)
    inst.components.spellcaster.canuseontargets = false
    inst.components.spellcaster:SetSpellTestFn(canteleport)		
	
end

AddPrefabPostInit("playerhouse_city", function(inst) inst:AddTag("gohomebase") end)
AddPrefabPostInit("firepit", function(inst) inst:AddTag("gohomebase") end)
AddPrefabPostInit("coldfirepit", function(inst) inst:AddTag("gohomebase") end)
AddPrefabPostInit("chiminea", function(inst) inst:AddTag("gohomebase") end)

AddPrefabPostInit("walkingstick", goHome)
AddPrefabPostInit("cane", goHome)


