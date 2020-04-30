require "prefabutil"

local assets = {
	Asset("ANIM", "anim/casket.zip"),
	Asset("IMAGE", "images/inventoryimages/casket.tex"),
    Asset("ATLAS", "images/inventoryimages/casket.xml"),	
	Asset("IMAGE", "images/casket.tex"),
	Asset("ATLAS", "images/casket.xml"),
}

local slotpos = {}
local spacer = 30
local posX
local poxY

for z = 0, 2 do
	for y = 7, 0, -1 do
		for x = 0, 4 do
			posX = 80*x-600 + 80*5*z + spacer*z
			posY = 80*y-100

			if y > 3 then
				posY = posY + spacer
			end

			table.insert(slotpos, Vector3(posX, posY, 0))
		end
	end
end

local function onopen(inst)
	inst.SoundEmitter:PlaySound("dontstarve/wilson/chest_open")
end 

local function onclose(inst) 
	inst.SoundEmitter:PlaySound("dontstarve/wilson/chest_close")
end 


local function onPickup(inst) 
	inst.components.casket:Add(inst)
end 


local function onDropped(inst) 
	inst.components.casket:Remove(inst)
end 


local function onhammered(inst, worker)	
	inst.components.lootdropper:DropLoot()
	inst.components.container:DropEverything()
	SpawnPrefab("collapse_small").Transform:SetPosition(inst.Transform:GetWorldPosition())
	inst.SoundEmitter:PlaySound("dontstarve/common/destroy_wood")	
	inst:Remove()
end

local function fn(Sim)	
    local inst = CreateEntity()
	
    inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("casket")
    inst.AnimState:SetBuild("casket")
	inst.AnimState:PlayAnimation("idle")

    MakeSmallPropagator(inst)
	inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/casket.xml"
    inst.components.inventoryitem.imagename = "casket"
	
	inst.entity:AddMiniMapEntity()
	inst.MiniMapEntity:SetIcon("casket.tex")
	
	if CAPY_DLC and IsDLCEnabled(CAPY_DLC) or IsDLCEnabled(PORKLAND_DLC) then 
	  MakeInventoryFloatable(inst, "idle", "idle")
	end
	
	inst:AddComponent("container")
	inst.components.container:SetNumSlots(#slotpos)
	
	inst.components.container.widgetslotpos = slotpos
	inst.components.container.widgetbgatlas = "images/casket-ui.xml"
	inst.components.container.widgetbgimage = "casket-ui.tex"
	
	
	inst.components.container.widgetpos = Vector3(0,-100,0)
	inst.components.container.side_align_tip = 0   
	
	--inst:AddComponent("lootdropper")

    inst:AddComponent("casket")

    inst.components.container.onopenfn = onopen
	inst.components.container.onclosefn = onclose

	inst.components.inventoryitem:SetOnDroppedFn(onDropped)
	inst.components.inventoryitem:SetOnPutInInventoryFn(onPickup)

    return inst
end

return Prefab("common/casket", fn, assets)