local assets =
{
	Asset("ANIM", "anim/compost_box.zip"),
    Asset("ANIM", "anim/ui_chest_2x2.zip"),	
	Asset("ATLAS", "images/inventoryimages/compost_box.xml"),
	Asset("ANIM", "anim/explode.zip"),
}

local prefabs =
{
	"collapse_small",
	"explode_small"
}

local function onopen(inst)
	if not inst:HasTag("burnt") then
		inst.AnimState:PlayAnimation("open")
		inst.SoundEmitter:PlaySound("dontstarve/wilson/chest_open")	
	end
end 

local function onclose(inst) 
	if not inst:HasTag("burnt") then
		inst.AnimState:PlayAnimation("close")
		inst.SoundEmitter:PlaySound("dontstarve/wilson/chest_close")		
	end
end 

local function onhammered(inst, worker)
	if inst:HasTag("fire") and inst.components.burnable then
		inst.components.burnable:Extinguish()
	end
	inst.components.lootdropper:DropLoot()
	if inst.components.container then inst.components.container:DropEverything() end
	SpawnPrefab("collapse_small").Transform:SetPosition(inst.Transform:GetWorldPosition())
	inst.SoundEmitter:PlaySound("dontstarve/common/destroy_wood")
	if inst.flies then 
		inst.flies:Remove() inst.flies = nil 
	end	
	inst:Remove()
end

local function onhit(inst, worker)
	if not inst:HasTag("burnt") then
	inst.AnimState:PlayAnimation("hit")
	inst.AnimState:PushAnimation("closed", false)
	if inst.components.container then 
		inst.components.container:DropEverything() 
		inst.components.container:Close()
	end
	end
end

local function onsave(inst, data)
	if inst:HasTag("burnt") or inst:HasTag("fire") then
        data.burnt = true
		if inst.flies then 
			inst.flies:Remove() inst.flies = nil 
		end	
    end
end

local function onload(inst, data)
	if data and data.burnt then
        inst.components.burnable.onburnt(inst)
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

local function itemtest(inst, item, slot)
	return (item.components.edible and item.components.perishable) or 
	item.prefab == "spoiled_food" or 
	item.prefab == "rottenegg" or 
	item.prefab == "heatrock" or 
	item:HasTag("frozen") or
	item:HasTag("icebox_valid")
end
--[[
local function OnExplodeFn(inst)
    local pos = Vector3(inst.Transform:GetWorldPosition())
    inst.SoundEmitter:KillSound("hiss")
    inst.SoundEmitter:PlaySound("dontstarve/common/blackpowder_explo")
	
	if inst.flies then 
		inst.flies:Remove() inst.flies = nil 
	end	

    local explode = SpawnPrefab("explode_small")
    local pos = inst:GetPosition()
    explode.Transform:SetPosition(pos.x, pos.y, pos.z)

    --local explode = PlayFX(pos,"explode", "explode", "small")
    explode.AnimState:SetBloomEffectHandle( "shaders/anim.ksh" )
    explode.AnimState:SetLightOverride(1)
end
]]
local function fn(Sim)
	local inst = CreateEntity()
    inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	
	MakeObstaclePhysics(inst, .3)
		
	local minimap = inst.entity:AddMiniMapEntity()	
	minimap:SetIcon("compost_box.tex")
	
	inst:AddTag("compost")
	inst:AddTag("structure")
	
	inst.flies = inst:SpawnChild("flies")
	--[[
	inst:AddComponent("explosive")
    inst.components.explosive:SetOnExplodeFn(OnExplodeFn)
    inst.components.explosive.explosivedamage = TUNING.GUNPOWDER_DAMAGE
	]]
	inst:AddComponent("sanityaura")
    inst.components.sanityaura.aura = -TUNING.SANITYAURA_TINY

    inst.AnimState:SetBank("compost_box")
    inst.AnimState:SetBuild("compost_box")
    inst.AnimState:PlayAnimation("close")
    
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
	--If the mod (RPG HUD) is installed
	inst.components.container.widgetbgimagetint = {r=1,g=.42,b=.33,a=1}

    inst:AddComponent("lootdropper")
    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(4)
    inst.components.workable:SetOnFinishCallback(onhammered)
    inst.components.workable:SetOnWorkCallback(onhit) 
	
	inst:ListenForEvent( "onbuilt", onbuilt)
	MakeSnowCovered(inst, .01)	
	
	MakeLargeBurnable(inst, 6+ math.random()*6)
	MakeLargePropagator(inst)
	
    return inst
end

STRINGS.NAMES.COMPOST_BOX 								= "Compost Box"
STRINGS.RECIPE_DESC.COMPOST_BOX 						= "Speeds up spoilage."

STRINGS.CHARACTERS.GENERIC.DESCRIBE.COMPOST_BOX 		= "Smells awful!"
STRINGS.CHARACTERS.WILLOW.DESCRIBE.COMPOST_BOX 			= "How would I love to set that on fire!"
STRINGS.CHARACTERS.WOLFGANG.DESCRIBE.COMPOST_BOX 		= "Is box of yuck!"
STRINGS.CHARACTERS.WENDY.DESCRIBE.COMPOST_BOX 			= "It is what we all are destined to become."
STRINGS.CHARACTERS.WX78.DESCRIBE.COMPOST_BOX 			= "AIR HAZARD DETECTED"
STRINGS.CHARACTERS.WICKERBOTTOM.DESCRIBE.COMPOST_BOX 	= "It helps speed up the spoiling process."
STRINGS.CHARACTERS.WOODIE.DESCRIBE.COMPOST_BOX 			= "Phew, that stinks!"
STRINGS.CHARACTERS.WAXWELL.DESCRIBE.COMPOST_BOX 		= "Great, a box full of rot to make more rot."

if IsDLCEnabled(REIGN_OF_GIANTS) then
	STRINGS.CHARACTERS.WATHGRITHR.DESCRIBE.COMPOST_BOX 	= "Fööd from times öf löre."
	STRINGS.CHARACTERS.WEBBER.DESCRIBE.COMPOST_BOX 		= "Disgusting!"
end
	
if IsDLCEnabled(CAPY_DLC) then 
	STRINGS.CHARACTERS.WOODLEGS.DESCRIBE.COMPOST_BOX	= "Tha smell!"
	STRINGS.CHARACTERS.WALANI.DESCRIBE.COMPOST_BOX		= "Not something I want to stay around."
	STRINGS.CHARACTERS.WARLY.DESCRIBE.COMPOST_BOX		= "I don't want to put in anything I can still cook."
end

return	Prefab("common/compost_box", fn, assets),
		MakePlacer("common/compost_box_placer", "compost_box", "compost_box", "closed") 
