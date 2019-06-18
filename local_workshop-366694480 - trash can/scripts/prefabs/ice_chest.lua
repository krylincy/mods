local assets =
{
	Asset("ANIM", "anim/ice_chest.zip"),
    Asset("ANIM", "anim/ui_chest_4x4.zip"),	
	Asset("ATLAS", "images/inventoryimages/ice_chest.xml"),
}

local prefabs =
{
	"collapse_small",
}

local function onopen(inst)
	inst.AnimState:PlayAnimation("open")
	inst.SoundEmitter:PlaySound("dontstarve/wilson/chest_open")	
end 

local function onclose(inst) 
	inst.AnimState:PlayAnimation("close")
	inst.SoundEmitter:PlaySound("dontstarve/wilson/chest_close")		
end 

local function onhammered(inst, worker)
	inst.components.lootdropper:DropLoot()
	inst.components.container:DropEverything()
	SpawnPrefab("collapse_small").Transform:SetPosition(inst.Transform:GetWorldPosition())
	inst.SoundEmitter:PlaySound("dontstarve/common/destroy_metal")
	
	inst:Remove()
end

local function onhit(inst, worker)
	inst.AnimState:PlayAnimation("hit")
	inst.components.container:DropEverything() 
	inst.AnimState:PushAnimation("closed", false)
	inst.components.container:Close()
end

local function onbuilt(inst)
	inst.AnimState:PlayAnimation("place")
	inst.AnimState:PushAnimation("closed", false)
end

local slotpos = {}

for y = 3, 0, -1 do
	for x = 0, 3 do
		table.insert(slotpos, Vector3(80*x-80*2+40, 80*y-80*2+40,0))
	end
end

local function itemtest(inst, item, slot)
	return (item.components.edible and item.components.perishable) or 
	item.prefab == "spoiled_food" or 
	item.prefab == "rottenegg" or 
	item.prefab == "heatrock" or 
	item:HasTag("frozen") or
	item:HasTag("icebox_valid")
end

local function onFloodedStart(inst)
	inst:RemoveTag("fridge")
end 

local function onFloodedEnd(inst)
	inst:AddTag("fridge")
end 

local function fn(Sim)
	local inst = CreateEntity()
		
	inst:AddTag("fridge")
    inst:AddTag("structure")
	
    inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	
	MakeObstaclePhysics(inst, .3)
		
	local minimap = inst.entity:AddMiniMapEntity()	
	minimap:SetIcon("ice_chest.tex")
	
    inst.AnimState:SetBank("ice_chest")
    inst.AnimState:SetBuild("ice_chest")
    inst.AnimState:PlayAnimation("close")
    
    inst:AddComponent("inspectable")
    inst:AddComponent("container")
	inst.components.container.itemtestfn = itemtest
    inst.components.container:SetNumSlots(#slotpos)
    
    inst.components.container.onopenfn = onopen
    inst.components.container.onclosefn = onclose

	inst.components.container.widgetslotpos = slotpos
    inst.components.container.widgetanimbank = "ui_chest_4x4"
    inst.components.container.widgetanimbuild = "ui_chest_4x4"	
    inst.components.container.widgetpos = Vector3(0,200,0)
	inst.components.container.side_align_tip = 160
	--If the mod (RPG HUD) is installed
	inst.components.container.widgetbgimagetint = {r=.44,g=.74,b=1,a=1}

    inst:AddComponent("lootdropper")
    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(6)
    inst.components.workable:SetOnFinishCallback(onhammered)
    inst.components.workable:SetOnWorkCallback(onhit) 
	
	if IsDLCEnabled(CAPY_DLC) then 
		inst:AddComponent("floodable")
		inst.components.floodable.onStartFlooded = onFloodedStart
		inst.components.floodable.onStopFlooded = onFloodedEnd
		inst.components.floodable.floodEffect = "shock_machines_fx"
		inst.components.floodable.floodSound = "dontstarve_DLC002/creatures/jellyfish/electric_land"
	end
	
	inst:ListenForEvent( "onbuilt", onbuilt)
	MakeSnowCovered(inst, .01)	
	
    return inst
end

STRINGS.NAMES.ICE_CHEST 								= "Ice Chest"
STRINGS.RECIPE_DESC.ICE_CHEST 							= "It's like a box full of snow."

STRINGS.CHARACTERS.GENERIC.DESCRIBE.ICE_CHEST 			= "Smells like winter."
STRINGS.CHARACTERS.WILLOW.DESCRIBE.ICE_CHEST 			= "Not something I prefer being next to."
STRINGS.CHARACTERS.WOLFGANG.DESCRIBE.ICE_CHEST 			= "Is big enough to store much food."
STRINGS.CHARACTERS.WENDY.DESCRIBE.ICE_CHEST 			= "It may be cold as my heart."
STRINGS.CHARACTERS.WX78.DESCRIBE.ICE_CHEST 				= "CONTINUE, MY COLD BROTHER"
STRINGS.CHARACTERS.WICKERBOTTOM.DESCRIBE.ICE_CHEST 		= "Stores more supplies than a regular Ice Box."
STRINGS.CHARACTERS.WOODIE.DESCRIBE.ICE_CHEST 			= "Ahhhh. Closer to home as it can get."
STRINGS.CHARACTERS.WAXWELL.DESCRIBE.ICE_CHEST 			= "A small snow storm in a box."

if IsDLCEnabled(REIGN_OF_GIANTS) then 
	STRINGS.CHARACTERS.WATHGRITHR.DESCRIBE.ICE_CHEST 	= "A wild blizzard stirs within!"
	STRINGS.CHARACTERS.WEBBER.DESCRIBE.ICE_CHEST 		= "More food will not spoil as fast."
end

if IsDLCEnabled(CAPY_DLC) then 
	STRINGS.CHARACTERS.WOODLEGS.DESCRIBE.ICE_CHEST		= "Me food be best kept in 're."
	STRINGS.CHARACTERS.WALANI.DESCRIBE.ICE_CHEST		= "Nice and cool."
	STRINGS.CHARACTERS.WARLY.DESCRIBE.ICE_CHEST			= "Keeps my food and ingredients fresh."
end

return	Prefab("common/ice_chest", fn, assets),
		MakePlacer("common/ice_chest_placer", "ice_chest", "ice_chest", "closed") 
