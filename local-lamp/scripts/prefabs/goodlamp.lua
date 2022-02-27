require "prefabutil"

local assets=
{
	Asset("ANIM", "anim/lantern.zip"),
	Asset("ANIM", "anim/swap_lantern.zip"),
    Asset("SOUND", "sound/wilson.fsb"),
    Asset("INV_IMAGE", "lantern_lit"),
    Asset("ATLAS", "images/inventoryimages/path_light.xml"),
    Asset("IMAGE", "images/inventoryimages/path_light.tex"),
}


local function fuelupdate(inst)
    local fuelpercent = inst.components.fueled:GetPercent() * 100
	fuelpercent =  math.floor(fuelpercent)
    inst.components.inspectable:SetDescription(fuelpercent.."%")
end

local function turnon(inst)
    if not inst.components.fueled:IsEmpty() then
        if not inst.components.machine.ison then
            if inst.components.fueled then
                inst.components.fueled:StartConsuming()        
            end
            inst.Light:Enable(true)
            inst.AnimState:PlayAnimation("idle_on")

            inst.components.machine.ison = true

            inst.SoundEmitter:PlaySound("dontstarve/wilson/lantern_on")
        end
    end
end

local function turnoff(inst)
	if inst.components.machine.ison then
		if inst.components.fueled then
			inst.components.fueled:StopConsuming()        
		end

		inst.Light:Enable(false)
		inst.AnimState:PlayAnimation("idle_off")

	
		inst.SoundEmitter:PlaySound("dontstarve/wilson/lantern_off")
		inst.components.machine.ison = false
	end
end

local function OnLoad(inst, data)
	fuelupdate(inst)
    if inst.components.machine and inst.components.machine.ison then
        inst.AnimState:PlayAnimation("idle_on")
        turnon(inst)
    else
        inst.AnimState:PlayAnimation("idle_off")
        turnoff(inst)
    end
end

local function ondropped(inst)
    turnoff(inst)
    turnon(inst)
end

local function onpickup(inst)
	turnon(inst)
end

local function onputininventory(inst)
    turnoff(inst)
end
--
local function onequip(inst, owner) 
    owner.AnimState:Show("ARM_carry") 
    owner.AnimState:Hide("ARM_normal")
    owner.AnimState:OverrideSymbol("lantern_overlay", "swap_lantern", "lantern_overlay")
	
    if inst.components.fueled:IsEmpty() then
        owner.AnimState:OverrideSymbol("swap_object", "swap_lantern", "swap_lantern_off")
		owner.AnimState:Hide("LANTERN_OVERLAY") 
    else
        owner.AnimState:OverrideSymbol("swap_object", "swap_lantern", "swap_lantern_on")
		owner.AnimState:Show("LANTERN_OVERLAY") 
    end
    turnon(inst)
end

local function onunequip(inst, owner) 
    owner.AnimState:Hide("ARM_carry") 
    owner.AnimState:Show("ARM_normal")
    owner.AnimState:ClearOverrideSymbol("lantern_overlay")
	owner.AnimState:Hide("LANTERN_OVERLAY") 	
end

local function nofuel(inst)
    turnoff(inst)
	inst:Remove()
end

local function fuelupdate(inst)
    local fuelpercent = inst.components.fueled:GetPercent() * 100
	fuelpercent =  math.floor(fuelpercent)
    inst.components.inspectable:SetDescription(fuelpercent.."%")
end

local function onhammered(inst, worker)
	inst.components.lootdropper:DropLoot()
	inst:Remove()
	
end

local function onhit(inst, worker)
	turnoff(inst)
end

local function onfar(inst) 
	turnoff(inst)
end

local function onnear(inst) 
	if GetClock():IsDusk() or GetClock():IsNight() then
		turnon(inst)
	end
end

local function fn(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    MakeInventoryPhysics(inst)
    
    inst.AnimState:SetBank("lantern")
    inst.AnimState:SetBuild("lantern")
    inst.AnimState:PlayAnimation("idle_off")

    inst:AddTag("light")
    inst:AddTag("noautopickup")

    inst:AddComponent("inspectable")

    inst:AddComponent("fueled")
	inst.components.fueled:SetUpdateFn(fuelupdate)
	
	fuelupdate(inst)

-- inst:AddComponent("equippable")
	-- inst.components.equippable:SetOnEquip( onequip )
    -- inst.components.equippable:SetOnUnequip( onunequip )

	inst:AddComponent("inventoryitem")

    inst.components.inventoryitem:SetOnDroppedFn(ondropped)
    inst.components.inventoryitem:SetOnPutInInventoryFn(onputininventory)    
	inst.components.inventoryitem.atlasname = "images/inventoryimages/path_light.xml"
	inst.components.inventoryitem.imagename = "path_light"


    inst:AddComponent("machine")
    inst.components.machine.turnonfn = turnon
    inst.components.machine.turnofffn = turnoff
    inst.components.machine.cooldowntime = 0
    inst.components.machine.caninteractfn = function() 

		local player = GetPlayer()
		local item = player.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
		
		if item and item.name == "Hammer" then return false end
		return true
	end

	local maxfuledLantern = TUNING.LANTERN_LIGHTTIME * 10
    inst.components.fueled:InitializeFuelLevel(maxfuledLantern)
    inst.components.fueled:SetDepletedFn(nofuel)
	inst.components.fueled:SetSections(100)
    inst.components.fueled.accepting = true
    inst.components.fueled.maxfuel = maxfuledLantern
	inst.components.fueled.ontakefuelfn = function() fuelupdate(inst) end
	inst.components.fueled:SetSectionCallback(
        function(section)
            fuelupdate(inst)
        end)

    local light = inst.entity:AddLight()
	light:SetFalloff(0.9)
	light:SetIntensity(0.7)
	light:SetRadius(14)
	inst.Light:SetColour(180/255, 195/255, 170/255)
	inst.Light:Enable(false)
	
	inst:AddComponent("playerprox")
	inst.components.playerprox:SetDist(30, 40)
    inst.components.playerprox:SetOnPlayerNear(onnear)
    inst.components.playerprox:SetOnPlayerFar(onfar)
	
	inst:ListenForEvent( "daytime", function() turnoff(inst) end, GetWorld()) 
	--inst:ListenForEvent( "dusktime", function() 
	inst:ListenForEvent( "nighttime", function() 
		if inst.components.playerprox:IsPlayerClose() then
			turnon(inst)
		end
	end, GetWorld())
    

    inst.OnLoad = OnLoad

    return inst
end


return Prefab( "common/goodlamp", fn, assets),
MakePlacer("common/goodlamp_placer", "lantern", "lantern", "idle_off")
