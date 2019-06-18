local assets =
{
	Asset("ANIM", "anim/crate_material.zip"),
	Asset("ANIM", "anim/ui_chest_3x3.zip"),
	Asset("ATLAS", "images/inventoryimages/crate_material.xml"),
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

for y = 2, 0, -1 do
	for x = 0, 2 do
		table.insert(slotpos, Vector3(80*x-80*2+80, 80*y-80*2+80,0))
	end
end

local widgetbuttoninfo = 
{
	text = "Hammer",
	position = Vector3(0, -135, 0),
	fn = function(inst)
		if inst.components.container then inst.components.container:DropEverything() end
		SpawnPrefab("collapse_small").Transform:SetPosition(inst.Transform:GetWorldPosition())
		inst.SoundEmitter:PlaySound("dontstarve/common/destroy_material")
		inst:Remove()
	end,
}


local function itemtest(inst, item, slot)
	if IsDLCEnabled(CAPY_DLC) then
		if 
		item.prefab == "log" or
		item.prefab == "rocks" or
		item.prefab == "cutgrass" or
		item.prefab == "bamboo" or
		item.prefab == "coral" or
		--
		item.prefab == "boards" or
		item.prefab == "cutstone" or
		item.prefab == "rope" or
		item.prefab == "fabric" or
		item.prefab == "limestone" or
		--
		item.prefab == "twigs" or
		item.prefab == "flint" or
		item.prefab == "vine" or
		item.prefab == "sand" or
		item.prefab == "palmleaf"
		then
			return true
		end
		return false
	else
		if 
		item.prefab == "log" or
		item.prefab == "rocks" or
		item.prefab == "cutgrass" or
		--
		item.prefab == "boards" or
		item.prefab == "cutstone" or
		item.prefab == "rope" or
		--
		item.prefab == "twigs" or
		item.prefab == "flint"
		then
			return true
		end
		return false
	end
end

local function fn(Sim)
	local inst = CreateEntity()
    inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	
	MakeObstaclePhysics(inst, 1.0)
		
	local minimap = inst.entity:AddMiniMapEntity()	
	minimap:SetIcon("crate_material.tex")
	
	inst:AddTag("structure")
	inst:AddTag("chest")
    inst.AnimState:SetBank("crate_material")
    inst.AnimState:SetBuild("crate_material")
    inst.AnimState:PlayAnimation("close")
    
    inst:AddComponent("inspectable")
    inst:AddComponent("container")
    inst.components.container:SetNumSlots(#slotpos)
	inst.components.container.itemtestfn = itemtest
    
    inst.components.container.onopenfn = onopen
    inst.components.container.onclosefn = onclose

    inst.components.container.widgetslotpos = slotpos
    inst.components.container.widgetanimbank = "ui_chest_3x3"
    inst.components.container.widgetanimbuild = "ui_chest_3x3"
    inst.components.container.widgetpos = Vector3(0,200,0)
    inst.components.container.side_align_tip = 160
	inst.components.container.widgetbuttoninfo = widgetbuttoninfo
	
	inst.components.container.onopenfn = onopen
    inst.components.container.onclosefn = onclose
	
	inst:ListenForEvent( "onbuilt", onbuilt)
	MakeSnowCovered(inst, .01)	
	
    return inst
end

STRINGS.NAMES.CRATE_MATERIAL 							= "Pitcrate"
STRINGS.RECIPE_DESC.CRATE_MATERIAL 						= "For storing the most basic of materials."

STRINGS.CHARACTERS.GENERIC.DESCRIBE.CRATE_MATERIAL 		= "Now I can dump my items without worry."
STRINGS.CHARACTERS.WILLOW.DESCRIBE.CRATE_MATERIAL 		= "It's dark inside. It needs fire!"
STRINGS.CHARACTERS.WOLFGANG.DESCRIBE.CRATE_MATERIAL 	= "Is dirty hole."
STRINGS.CHARACTERS.WENDY.DESCRIBE.CRATE_MATERIAL 		= "It's deep and dark as my soul."
STRINGS.CHARACTERS.WX78.DESCRIBE.CRATE_MATERIAL 		= "MATERIAL STORAGE UNIT"
STRINGS.CHARACTERS.WICKERBOTTOM.DESCRIBE.CRATE_MATERIAL = "A protective way to store refined items."
STRINGS.CHARACTERS.WOODIE.DESCRIBE.CRATE_MATERIAL 		= "It's a hole in the ground."
STRINGS.CHARACTERS.WAXWELL.DESCRIBE.CRATE_MATERIAL 		= "Why did I not think of this before?"

if IsDLCEnabled(REIGN_OF_GIANTS) then 
	STRINGS.CHARACTERS.WATHGRITHR.DESCRIBE.CRATE_MATERIAL 	= "I dö nöt hide fröm my enemies!"
	STRINGS.CHARACTERS.WEBBER.DESCRIBE.CRATE_MATERIAL 	= "We can play hide and seek!"
end
	
if IsDLCEnabled(CAPY_DLC) then 
	STRINGS.CHARACTERS.WOODLEGS.DESCRIBE.CRATE_MATERIAL	= "I can bury ma treasure."
	STRINGS.CHARACTERS.WALANI.DESCRIBE.CRATE_MATERIAL	= "It seems safe."
	STRINGS.CHARACTERS.WARLY.DESCRIBE.CRATE_MATERIAL	= "For emergency supplies."
end

return	Prefab("common/crate_material", fn, assets),
		MakePlacer("common/crate_material_placer", "crate_material", "crate_material", "closed") 
