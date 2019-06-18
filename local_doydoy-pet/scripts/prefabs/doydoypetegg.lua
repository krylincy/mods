local assets=
{
	Asset("ANIM", "anim/doydoypet_egg.zip"),
	Asset("IMAGE", "images/inventoryimages/doydoypetegg.tex"),
    Asset("ATLAS", "images/inventoryimages/doydoypetegg.xml"),
	Asset("IMAGE", "images/inventoryimages/doydoypetegg_cracked.tex"),
    Asset("ATLAS", "images/inventoryimages/doydoypetegg_cracked.xml"),
	Asset("IMAGE", "images/inventoryimages/doydoypetegg_cooked.tex"),
    Asset("ATLAS", "images/inventoryimages/doydoypetegg_cooked.xml"),
}

local prefabs = 
{
	"doydoypetbaby",
	"doydoypetegg_cracked",
	"doydoypetegg_cooked",
	"spoiled_food",
}

local function Hatch(inst)   
    local doydoypetbaby = SpawnPrefab("doydoypetbaby")
    doydoypetbaby.Transform:SetPosition(inst.Transform:GetWorldPosition())
    doydoypetbaby.sg:GoToState("hatch")
	doydoypetbaby:AddTag("doydoypet_female")

    inst:Remove()
end


local function OnDropped(inst)	
	Hatch(inst)
end

local function OnEaten(inst, eater)
    if eater.components.talker then
        eater.components.talker:Say( GetString(eater.prefab, "EAT_FOOD", "TALLBIRDEGG_CRACKED") )
    end
end


local function commonfn()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    
    MakeInventoryPhysics(inst)
    
    inst.AnimState:SetBuild("doydoypet_egg")
    inst.AnimState:SetBank("egg")
    inst.AnimState:PlayAnimation("egg")
    
    inst:AddComponent("inspectable")
    
    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/doydoypetegg.xml"
    inst.components.inventoryitem.imagename = "doydoypetegg"

    inst:AddComponent("edible")

	inst:AddComponent("perishable")
	inst.components.perishable:SetPerishTime(TUNING.PERISH_FAST)
	inst.components.perishable:StartPerishing()
	inst.components.perishable.onperishreplacement = "spoiled_food"
	
    inst:AddTag("cattoy")
    inst:AddComponent("tradable")
    
    return inst
end

local function defaultfn()
	local inst = commonfn()

	inst.entity:AddSoundEmitter()

    inst.AnimState:PlayAnimation("egg")
    inst.components.edible.healthvalue = TUNING.HEALING_SMALL
    inst.components.edible.hungervalue = TUNING.CALORIES_MED

    inst:AddComponent("cookable")
    inst.components.cookable.product = "doydoypetegg_cooked"

    inst.components.inventoryitem:SetOnDroppedFn(OnDropped)

	return inst
end

local function crackedfn()
    local inst = defaultfn()	
	inst.AnimState:PlayAnimation("idle_crack")
    
    inst.components.edible:SetOnEatenFn(OnEaten)	
	
	inst.components.inventoryitem.atlasname = "images/inventoryimages/doydoypetegg_cracked.xml"
    inst.components.inventoryitem.imagename = "doydoypetegg_cracked"

    return inst
end

local function cookedfn()
	local inst = commonfn()
    
    inst:AddComponent("stackable")

    inst.AnimState:PlayAnimation("cooked")
    inst.components.edible.healthvalue = 0
    inst.components.edible.hungervalue = TUNING.CALORIES_LARGE
    	
	inst.components.inventoryitem.atlasname = "images/inventoryimages/doydoypetegg_cooked.xml"
    inst.components.inventoryitem.imagename = "doydoypetegg_cooked"
    
	return inst
end


return Prefab( "common/inventory/doydoypetegg", defaultfn, assets, prefabs),
		Prefab( "common/inventory/doydoypetegg_cracked", crackedfn, assets),
		Prefab( "common/inventory/doydoypetegg_cooked", cookedfn, assets) 
