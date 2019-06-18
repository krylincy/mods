require "prefabutil"

local assets =
{
	Asset("ANIM", "anim/trash_can.zip"),
    Asset("ANIM", "anim/ui_cookpot_1x4.zip"),	
	Asset("ATLAS", "images/inventoryimages/trash_can.xml"),
}

local prefabs =
{
	"collapse_small",
}

local function onopen(inst)
	inst.AnimState:PlayAnimation("open")
	inst.SoundEmitter:PlaySound("dontstarve/common/cookingpot_open", "open")
end 

local function onclose(inst) 
	inst.AnimState:PlayAnimation("close")
	inst.SoundEmitter:PlaySound("dontstarve/common/cookingpot_close", "close")	
	inst.components.container:DestroyContents()
end 

local function onhammered(inst, worker)
	if inst:HasTag("fire") and inst.components.burnable then
		inst.components.burnable:Extinguish()
	end
	inst.components.lootdropper:DropLoot()
	if inst.components.container then inst.components.container:DropEverything() end
	SpawnPrefab("collapse_small").Transform:SetPosition(inst.Transform:GetWorldPosition())
	inst.SoundEmitter:PlaySound("dontstarve/common/destroy_metal")
	inst:Remove()
end

local function onhit(inst, worker)
	inst.AnimState:PlayAnimation("hit")
	inst.AnimState:PushAnimation("closed", false)
	if inst.components.container then 
		inst.components.container:DropEverything() 
		inst.components.container:Close()
	end
end

local function onbuilt(inst)
	inst.AnimState:PlayAnimation("place")
	inst.AnimState:PushAnimation("closed", false)
end

local slotpos = {	Vector3(0,64+32+8+4,0), 
					Vector3(0,32+4,0),
					Vector3(0,-(32+4),0), 
					Vector3(0,-(64+32+8+4),0)}

local widgetbuttoninfo = 
{
	text = "Destroy",
	position = Vector3(0, -165, 0),
	fn = function(inst)
		inst.components.container:DestroyContents()
	end,
}

local function itemtest(inst, item, slot)
	if IsDLCEnabled(CAPY_DLC) then
		if item:HasTag("irreplaceable") or
		item.prefab == "lighter" or
		item.prefab == "abigail_flower" or
		item.prefab == "balloons_empty" or
		item.prefab == "waxwelljournal" or
		item.prefab == "lucy" or
		item.prefab == "woodlegs_key1" or
		item.prefab == "woodlegs_key2" or
		item.prefab == "woodlegs_key3" or
		item.prefab == "portablecookpot_item"
		then
			return false
		end
		return true
	else
		if item:HasTag("irreplaceable") or
		item.prefab == "lighter" or
		item.prefab == "abigail_flower" or
		item.prefab == "balloons_empty" or
		item.prefab == "waxwelljournal" or
		item.prefab == "lucy"
		then
			return false
		end
		return true
	end
end

local function fn(Sim)
	local inst = CreateEntity()
    inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	
	MakeObstaclePhysics(inst, .1)
		
	local minimap = inst.entity:AddMiniMapEntity()	
	minimap:SetIcon("trash_can.tex")
	
	inst:AddTag("structure")
	inst:AddTag("chest")
    inst.AnimState:SetBank("trash_can")
    inst.AnimState:SetBuild("trash_can")
    inst.AnimState:PlayAnimation("close")
    
    inst:AddComponent("inspectable")
    inst:AddComponent("container")
    inst.components.container.itemtestfn = itemtest
    inst.components.container:SetNumSlots(4)
    inst.components.container.widgetslotpos = slotpos
    inst.components.container.widgetanimbank = "ui_cookpot_1x4"
    inst.components.container.widgetanimbuild = "ui_cookpot_1x4"
    inst.components.container.widgetpos = Vector3(200,0,0)
    inst.components.container.side_align_tip = 100
    inst.components.container.widgetbuttoninfo = widgetbuttoninfo
    
    inst.components.container.onopenfn = onopen
    inst.components.container.onclosefn = onclose

    inst:AddComponent("lootdropper")
    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(2)
    inst.components.workable:SetOnFinishCallback(onhammered)
    inst.components.workable:SetOnWorkCallback(onhit)
	
	inst:ListenForEvent( "onbuilt", onbuilt)
	MakeSnowCovered(inst, .01)	
	
    return inst
end

STRINGS.NAMES.TRASH_CAN 								= "Trash Can"
STRINGS.RECIPE_DESC.TRASH_CAN 							= "What goes in does not come out."

STRINGS.CHARACTERS.GENERIC.DESCRIBE.TRASH_CAN 			= "It's a bottomless pit-in-a-can."
STRINGS.CHARACTERS.WILLOW.DESCRIBE.TRASH_CAN 			= "How deep does this go?"
STRINGS.CHARACTERS.WOLFGANG.DESCRIBE.TRASH_CAN 			= "Is good for useless junk."
STRINGS.CHARACTERS.WENDY.DESCRIBE.TRASH_CAN 			= "I can see only darkness within."
STRINGS.CHARACTERS.WX78.DESCRIBE.TRASH_CAN 				= "DELETES UNWANTED ITEMS"
STRINGS.CHARACTERS.WICKERBOTTOM.DESCRIBE.TRASH_CAN 		= "A container to dispose of unneeded items."
STRINGS.CHARACTERS.WOODIE.DESCRIBE.TRASH_CAN 			= "Junk goes in."
STRINGS.CHARACTERS.WAXWELL.DESCRIBE.TRASH_CAN 			= "Keeps the place clean and orderly."

if IsDLCEnabled(REIGN_OF_GIANTS) then 
	STRINGS.CHARACTERS.WATHGRITHR.DESCRIBE.TRASH_CAN 	= "Deströyer öf junk!"
	STRINGS.CHARACTERS.WEBBER.DESCRIBE.TRASH_CAN 		= "It is like a bottomless pit!"
end

if IsDLCEnabled(CAPY_DLC) then 
	STRINGS.CHARACTERS.WOODLEGS.DESCRIBE.TRASH_CAN		= "Put me junk in 'er."
	STRINGS.CHARACTERS.WALANI.DESCRIBE.TRASH_CAN		= "Keeping it clean."
	STRINGS.CHARACTERS.WARLY.DESCRIBE.TRASH_CAN			= "Best to keep the area clean and tidy."
end

return	Prefab("common/trash_can", fn, assets),
		MakePlacer("common/trash_can_placer", "trash_can", "trash_can", "closed") 
