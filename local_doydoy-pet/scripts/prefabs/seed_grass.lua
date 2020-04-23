local assets=
{
	Asset("ANIM", "anim/seed_grass.zip"),
	Asset("SOUND", "sound/common.fsb"),
}

local prefabs =
{
    "seeds",
    "dug_seed_grass",
}    

local function onpickedfn(inst)
    inst.SoundEmitter:PlaySound("dontstarve/wilson/pickup_reeds")
    inst.AnimState:PlayAnimation("picking")
    inst.AnimState:PushAnimation("picked")
end

local function onregenfn(inst)
    inst.AnimState:PlayAnimation("grow")
    inst.AnimState:PushAnimation("idle", true)
end

local function makeemptyfn(inst)
	inst.AnimState:PlayAnimation("picked")
end

local function dig_up(inst, chopper)	
	if inst.components.pickable then
		local bush = inst.components.lootdropper:SpawnLootPrefab("dug_seed_grass")
	end
	inst:Remove()
end


local function fn(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
    local sound = inst.entity:AddSoundEmitter()
	--local minimap = inst.entity:AddMiniMapEntity()
	--minimap:SetIcon( "reeds.png" )
	
	local seg_time = 30 --each segment of the clock is 30 seconds
	local total_day_time = seg_time*14 + math.random() -- one day has 16 segments
    
    anim:SetBank("grass")
    anim:SetBuild("seed_grass")
    anim:PlayAnimation("idle",true)
    anim:SetTime(math.random()*2)
    local color = 0.75 + math.random() * 0.25
    anim:SetMultColour(color, color, color, 1)


    inst:AddComponent("pickable")
    inst.components.pickable.picksound = "dontstarve/wilson/pickup_reeds"
    inst.components.pickable:SetUp("seeds", total_day_time)
	inst.components.pickable.onregenfn = onregenfn
	inst.components.pickable.onpickedfn = onpickedfn
    inst.components.pickable.makeemptyfn = makeemptyfn

    inst.components.pickable.SetRegenTime = 103

    inst:AddTag("doydoypetfood")
	inst:AddTag("fireimmune")
    inst:AddComponent("inspectable")
	inst:AddComponent("lootdropper")
	
	inst:AddComponent("workable")
	inst.components.workable:SetWorkAction(ACTIONS.DIG)
	inst.components.workable:SetOnFinishCallback(dig_up)
	inst.components.workable:SetWorkLeft(1)
    
    
    ---------------------            
	MakeSmallBurnable(inst, TUNING.SMALL_FUEL)
    MakeSmallPropagator(inst)
	--MakeNoGrowInWinter(inst)    
    ---------------------   
    
    return inst
end

return Prefab( "forest/objects/seed_grass", fn, assets, prefabs) 
