local assets=
{
	Asset("ANIM", "anim/amulets_flower.zip"),
	Asset("ANIM", "anim/torso_amulets_flower.zip"),
	Asset("IMAGE", "images/inventoryimages/floweramulet.tex"),
    Asset("ATLAS", "images/inventoryimages/floweramulet.xml"),
}

local function onequip(inst, owner) 
    owner.AnimState:OverrideSymbol("swap_body", "torso_amulets_flower", "yellowamulet")

    if TUNING.FLOWERAMULET_DURABILITY == 1 and inst.components.fueled then
        inst.components.fueled:StartConsuming()        
    end
	
	if not GetPlayer().killedplantfn then
		GetPlayer().killedplantfn = function() end
	end
	owner:AddTag("plantkin")

end

local function onunequip(inst, owner) 
    owner.AnimState:ClearOverrideSymbol("swap_body")
    if TUNING.FLOWERAMULET_DURABILITY == 1 and inst.components.fueled then
        inst.components.fueled:StopConsuming()        
    end

	owner:RemoveTag("plantkin")
end

local function onfinished(inst)
    inst:Remove()
end

local function floweramulet(inst)
	local inst = CreateEntity()
	
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	MakeInventoryPhysics(inst)   

	inst.AnimState:SetBank("amulets")
	inst.AnimState:SetBuild("amulets_flower")
	
	inst:AddComponent("inspectable")
	
	inst:AddComponent("equippable")
	inst.components.equippable.equipslot = EQUIPSLOTS.NECK or EQUIPSLOTS.BODY
	
		
	inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.foleysound = "dontstarve/movement/foley/jewlery"
	inst.AnimState:PlayAnimation("floweramulet")
	
	inst.components.inventoryitem.atlasname = "images/inventoryimages/floweramulet.xml"
    inst.components.inventoryitem.imagename = "floweramulet"

	inst.components.equippable:SetOnEquip( onequip )
	inst.components.equippable:SetOnUnequip( onunequip )
	--inst.components.inventoryitem:SetOnDroppedFn(function(inst) inst.Light:Enable(false) end)

	if TUNING.FLOWERAMULET_DURABILITY == 1 then
		inst:AddComponent("fueled")
		inst.components.fueled.accepting = false
		inst.components.fueled.fueltype = "MAGIC"
		inst.components.fueled:InitializeFuelLevel(TUNING.YELLOWAMULET_FUEL)
		inst.components.fueled:SetDepletedFn(onfinished)
	end
	
    return inst
end

return Prefab("common/inventory/floweramulet", floweramulet, assets)
