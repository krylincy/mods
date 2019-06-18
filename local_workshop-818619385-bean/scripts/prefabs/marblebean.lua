require "prefabutil"

local assets =
{
    Asset("ANIM", "anim/marblebean.zip"),
	Asset("IMAGE", "images/inventoryimages/marblebean.tex"),
	Asset("ATLAS", "images/inventoryimages/marblebean.xml"),
}

local prefabs =
{
    "marblebean_sapling",
}

local function ondeploy(inst, pt, deployer)
    local sapling = SpawnPrefab("marblebean_sapling")
    sapling:StartGrowing()
    sapling.Transform:SetPosition(pt:Get())
    sapling.SoundEmitter:PlaySound("dontstarve/wilson/plant_tree")
    inst:Remove()
end

local notags = {'NOBLOCK', 'player', 'FX'}
local function test_ground(inst, pt)
	local tiletype = GetGroundTypeAtPosition(pt)
	local ground_OK = tiletype ~= GROUND.IMPASSABLE and tiletype ~= GROUND.WOODFLOOR and tiletype ~= GROUND.CARPET and tiletype ~= GROUND.CHECKER and tiletype < GROUND.UNDERGROUND
	if ground_OK then
	    local ents = TheSim:FindEntities(pt.x,pt.y,pt.z, 4, nil, notags) -- or we could include a flag to the search?
		local min_spacing = inst.components.deployable.min_spacing or 2

	    for k, v in pairs(ents) do
			if v ~= inst and v:IsValid() and v.entity:IsVisible() and not v.components.placer and v.parent == nil then
				if distsq( Vector3(v.Transform:GetWorldPosition()), pt) < min_spacing*min_spacing then
					return false
				end
			end
		end
		return true
	end
	return false
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("marblebean")
    inst.AnimState:SetBuild("marblebean")
    inst.AnimState:PlayAnimation("idle")

    inst:AddTag("cattoy")
    inst:AddTag("molebait")

    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/marblebean.xml"
	inst.components.inventoryitem:ChangeImageName("marblebean")
	
	inst:AddComponent("deployable")
    inst.components.deployable.test = test_ground
    inst.components.deployable.ondeploy = ondeploy	
    return inst
end

STRINGS.NAMES.MARBLEBEAN = "Marble Bean"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.MARBLEBEAN = "I traded the old family cow for it."
STRINGS.RECIPE_DESC.MARBLEBEAN = "Make marble renewable!"

return Prefab("marblebean", fn, assets, prefabs),
	MakePlacer("marblebean_placer", "marblebean", "marblebean", "idle_planted")