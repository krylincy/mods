local assets=
{
    Asset("ANIM", "anim/dug_seed_grass.zip"),
    Asset("ATLAS", "images/inventoryimages/dug_seed_grass.xml"),
    Asset("IMAGE", "images/inventoryimages/dug_seed_grass.tex"),

}

local function test_ground(inst, pt)
	local tiletype = GetGroundTypeAtPosition(pt)
	local ents = TheSim:FindEntities(pt.x,pt.y,pt.z, 1)
	local min_spacing = inst.components.deployable.min_spacing or 2

	for k, v in pairs(ents) do
		if v ~= inst and v.entity:IsValid() and v.entity:IsVisible() and not v:HasTag("player") and not v.components.placer and v.parent == nil and not v:HasTag("FX") then
			if distsq( Vector3(v.Transform:GetWorldPosition()), pt) < min_spacing*min_spacing then
				return false
			end
		end
	end
	
	return true
	
end

local function CanDeploy(inst) return true end

local function ondeploy(inst, pt)
	local tree = SpawnPrefab("seed_grass") 
	if tree then 
		tree.Transform:SetPosition(pt.x, pt.y, pt.z) 
		inst.components.stackable:Get():Remove()
		tree.components.pickable:OnTransplant()
		tree.SoundEmitter:PlaySound("dontstarve/wilson/plant_tree")
	end 
end

	local function fn(Sim)
		local inst = CreateEntity()
		inst.entity:AddTransform()
		inst.entity:AddAnimState()
		MakeInventoryPhysics(inst)
	    
		inst.AnimState:SetBank("dug")
		inst.AnimState:SetBuild("dug_seed_grass")
		inst.AnimState:PlayAnimation("dropped_seed_grass")

		inst:AddTag("fireimmune")
		inst:AddComponent("pickable")
		inst:AddComponent("stackable")
		inst.components.stackable.maxsize = TUNING.STACK_SIZE_LARGEITEM
		
		inst:AddComponent("inspectable")
		inst.components.inspectable.nameoverride = "dug_seed_grass"
		inst:AddComponent("inventoryitem")
		inst.components.inventoryitem.atlasname = "images/inventoryimages/dug_seed_grass.xml"
	    inst.components.inventoryitem.imagename = "dug_seed_grass"
		
		inst:AddComponent("fuel")
		inst.components.fuel.fuelvalue = TUNING.LARGE_FUEL
	    

        MakeMediumBurnable(inst)
	    MakeSmallPropagator(inst)
		
	    inst:AddComponent("deployable")
	    inst.components.deployable.ondeploy = ondeploy
	    inst.components.deployable.test = test_ground
	    inst.components.deployable.min_spacing = 2
	    
		
	    
		---------------------  
		return inst      
	end

	return Prefab( "common/objects/dug_seed_grass", fn, assets),
		MakePlacer( "common/dug_seed_grass_placer", "grass", "seed_grass", "picked")