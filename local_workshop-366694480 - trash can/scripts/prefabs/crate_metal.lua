local assets =
{
	Asset("ANIM", "anim/crate_metal.zip"),
    Asset("ANIM", "anim/ui_chest_2x2.zip"),	
	Asset("ATLAS", "images/inventoryimages/crate_metal.xml"),
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

local slotpos = {}

for y = 1, 2, 1 do
	for x = 0, 1 do
		table.insert(slotpos, Vector3(75*x-75*2+112, 75*y-75*2+75,0))
	end
end

local function fn(Sim)
	local inst = CreateEntity()
    inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	
	MakeObstaclePhysics(inst, .50)
		
	local minimap = inst.entity:AddMiniMapEntity()	
	minimap:SetIcon("crate_metal.tex")
	
	inst:AddTag("structure")
	inst:AddTag("chest")
    inst.AnimState:SetBank("crate_metal")
    inst.AnimState:SetBuild("crate_metal")
    inst.AnimState:PlayAnimation("closed")
    
    inst:AddComponent("inspectable")
    inst:AddComponent("container")
    inst.components.container:SetNumSlots(#slotpos)
    
    inst.components.container.onopenfn = onopen
    inst.components.container.onclosefn = onclose

	inst.components.container.widgetslotpos = slotpos
    inst.components.container.widgetanimbank = "ui_chest_2x2"
    inst.components.container.widgetanimbuild = "ui_chest_2x2"	
    inst.components.container.widgetpos = Vector3(0,200,0)
	inst.components.container.side_align_tip = 160

    inst:AddComponent("lootdropper")
    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(8)
    inst.components.workable:SetOnFinishCallback(onhammered)
    inst.components.workable:SetOnWorkCallback(onhit) 
	
	inst:ListenForEvent( "onbuilt", onbuilt)
	MakeSnowCovered(inst, .01)	
	
    return inst
end

STRINGS.NAMES.CRATE_METAL 								= "Metal Crate"
STRINGS.RECIPE_DESC.CRATE_METAL 						= "A fireproof metal box."

STRINGS.CHARACTERS.GENERIC.DESCRIBE.CRATE_METAL 		= "How can such a small box be so complex?"
STRINGS.CHARACTERS.WILLOW.DESCRIBE.CRATE_METAL 			= "How boring."
STRINGS.CHARACTERS.WOLFGANG.DESCRIBE.CRATE_METAL 		= "Crate fears no fire."
STRINGS.CHARACTERS.WENDY.DESCRIBE.CRATE_METAL 			= "A puzzling box."
STRINGS.CHARACTERS.WX78.DESCRIBE.CRATE_METAL 			= "THIS BROTHER DEFENDS FROM FIRE"
STRINGS.CHARACTERS.WICKERBOTTOM.DESCRIBE.CRATE_METAL 	= "A fully automatic storage container."
STRINGS.CHARACTERS.WOODIE.DESCRIBE.CRATE_METAL 			= "It weighs a ton!"
STRINGS.CHARACTERS.WAXWELL.DESCRIBE.CRATE_METAL 		= "A fine example of workmanship."

if IsDLCEnabled(REIGN_OF_GIANTS) then 
	STRINGS.CHARACTERS.WATHGRITHR.DESCRIBE.CRATE_METAL 	= "It's thicker than armör."
	STRINGS.CHARACTERS.WEBBER.DESCRIBE.CRATE_METAL 		= "A box made of scrap metal."
end

if IsDLCEnabled(CAPY_DLC) then 
	STRINGS.CHARACTERS.WOODLEGS.DESCRIBE.CRATE_METAL	= "'Tis a fancy box."
	STRINGS.CHARACTERS.WALANI.DESCRIBE.CRATE_METAL		= "It looks like it weighs a ton."
	STRINGS.CHARACTERS.WARLY.DESCRIBE.CRATE_METAL		= "Keeps the fire out."
end

return	Prefab("common/crate_metal", fn, assets),
		MakePlacer("common/crate_metal_placer", "crate_metal", "crate_metal", "closed") 
