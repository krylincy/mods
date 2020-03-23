local assets = 
{
	Asset("ANIM", "anim/nightmare_timepiece.zip"),
	Asset("IMAGE", "images/inventoryimages/aporkalypse_manager.tex"),
    Asset("ATLAS", "images/inventoryimages/aporkalypse_manager.xml"),
	Asset("IMAGE", "images/inventoryimages/aporkalypse_manager_active.tex"),
    Asset("ATLAS", "images/inventoryimages/aporkalypse_manager_active.xml"),
}

local modName = KnownModIndex:GetModActualName("Aporkalypse Manager")
local REMOVE_AFTER_USE = GetModConfigData("REMOVE_AFTER_USE", modName)
local CHANGE_SANITY = GetModConfigData("CHANGE_SANITY", modName)
local WITH_FUNCTION = GetModConfigData("WITH_FUNCTION", modName)

local function status(inst, aclock)

    if aclock then	
        if aclock:IsActive() then
			inst.AnimState:PlayAnimation("idle_3")
			inst.components.inventoryitem.atlasname = "images/inventoryimages/aporkalypse_manager_active.xml"
			inst.components.inventoryitem:ChangeImageName("aporkalypse_manager_active")
			inst.components.inspectable:SetDescription("Aporkalypse now!")
		elseif aclock:IsNear() then
			inst.AnimState:PlayAnimation("idle_3")
			inst.components.inventoryitem.atlasname = "images/inventoryimages/aporkalypse_manager_active.xml"
			inst.components.inventoryitem:ChangeImageName("aporkalypse_manager_active")
			inst.components.inspectable:SetDescription("Aporkalypse is near")
		else
			inst.AnimState:PlayAnimation("idle_1")
			inst.components.inventoryitem.atlasname = "images/inventoryimages/aporkalypse_manager.xml"   
			inst.components.inventoryitem:ChangeImageName("aporkalypse_manager") 
			inst.components.inspectable:SetDescription("Everything's fine")
		end
	else
		inst.AnimState:PlayAnimation("idle_1")
			inst.components.inventoryitem.atlasname = "images/inventoryimages/aporkalypse_manager.xml"  
		inst.components.inventoryitem:ChangeImageName("aporkalypse_manager")  
		inst.components.inspectable:SetDescription("No Aporkalypse ...")
		
    end
end

local function updateStatus(inst)
	local aclock = GetAporkalypse()	
	status(inst, aclock)
	
	if aclock then
		local timeLeft = math.floor((aclock.begin_date - GetClock():GetTotalTime()) / TUNING.TOTAL_DAY_TIME)
		if aclock:IsActive() then
			inst.components.inspectable:SetDescription("APORKALYPSE")
			
			if WITH_FUNCTION then
				inst.components.useableitem.verb = "Stop Aporkalypse"	
				
				inst.components.useableitem:SetOnUseFn(function(inst)	
					local owner = inst.components.inventoryitem.owner	
					
					aclock:EndAporkalypse()
					aclock:ScheduleAporkalypse(GetClock():GetTotalTime() + 60 * TUNING.TOTAL_DAY_TIME)
					
					if owner and owner.components.sanity then
						owner.components.sanity:DoDelta(CHANGE_SANITY)
					end
					
					if REMOVE_AFTER_USE then
						inst:Remove()
					end
				end)	
			end			
		elseif aclock:GetFiestaActive() then
			inst.components.inspectable:SetDescription("Fiesta")
			
			if WITH_FUNCTION then
				inst.components.useableitem.verb = "Stop Fiesta"	
				
				inst.components.useableitem:SetOnUseFn(function(inst)	
					local owner = inst.components.inventoryitem.owner
					
					aclock:EndFiesta()
					
					if owner and owner.components.sanity then
						owner.components.sanity:DoDelta(CHANGE_SANITY)
					end
					
					if REMOVE_AFTER_USE then
						inst:Remove()
					end
				end)	
			end
		else		
			inst.components.inspectable:SetDescription(timeLeft.." days until Aporkalypse")
			
			if WITH_FUNCTION then
				inst.components.useableitem.verb = "Start Aporkalypse"	
				
				inst.components.useableitem:SetOnUseFn(function(inst)
					local owner = inst.components.inventoryitem.owner
					
					aclock:BeginAporkalypse()
					
					if owner and owner.components.sanity then
						owner.components.sanity:DoDelta(CHANGE_SANITY)
					end
					
					if REMOVE_AFTER_USE then
						inst:Remove()
					end
				end)
			end
		end
		
		if WITH_FUNCTION then
			inst.components.useableitem:SetCanInteractFn(function() return true end)
		end
		
	elseif WITH_FUNCTION then
		inst.components.useableitem:SetCanInteractFn(function() return false end)
		
	end
end

local function fn()
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	

	MakeInventoryPhysics(inst)

	anim:SetBank("nightmare_watch")
	anim:SetBuild("nightmare_timepiece")
	anim:PlayAnimation("idle_1")

	inst:AddComponent("inspectable")

	inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/aporkalypse_manager.xml"
	inst.components.inventoryitem.imagename = "aporkalypse_manager"
	
	if WITH_FUNCTION then
		inst:AddComponent("useableitem")
	end
	
	local aclock = GetAporkalypse()

	inst:ListenForEvent("beginaporkalypse", function() updateStatus(inst) end, GetWorld())
	inst:ListenForEvent("endaporkalypse", function() updateStatus(inst) end, GetWorld())
	inst:ListenForEvent("daytime", function() updateStatus(inst) end, GetWorld())
	updateStatus(inst)

	return inst
end

return Prefab("common/inventory/aporkalypse_manager", fn, assets)