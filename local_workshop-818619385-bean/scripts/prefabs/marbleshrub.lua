
local assets =
{
    Asset("ANIM", "anim/marbleshrub.zip"),
    Asset("ANIM", "anim/marbleshrub_build.zip"),
}

local prefabs =
{
    "marble",
    "marblebean",
    "rock_break_fx",
}

local NUM_BUILDS = 3
local NUM_GROWTH_STAGES = 3

local statedata =
{
	{ -- short
		idleanim    = "idle_short",
		hitanim     = "hit_short", 
		breakanim   = "mined_short",
		growanim    = "grow_tall_to_short",
		--growsound   = "dontstarve/common/together/marble_shrub/wilt_to_grow", 
		workleft    = TUNING.MARBLESHRUB_MINE_SMALL,
		--loot        = function() return {"marble"} end,
		loot        = {"marble"},
	},
	{ -- normal
		idleanim    = "idle_normal",
		hitanim     = "hit_normal", 
		breakanim   = "mined_normal",
		growanim    = "grow_short_to_normal", 
		--growsound   = "dontstarve/common/together/marble_shrub/grow", 
		workleft    = TUNING.MARBLESHRUB_MINE_NORMAL,
		--loot        = function() return math.random() < 0.75 and {"marble"} or {"marble", "marblebean"} end,
		loot        = {"marble", "marble"},
	},
	{ -- tall
		idleanim    = "idle_tall",
		hitanim     = "hit_tall", 
		breakanim   = "mined_tall",
		growanim    = "grow_normal_to_tall", 
		--growsound   = "dontstarve/common/together/marble_shrub/grow", 
		workleft    = TUNING.MARBLESHRUB_MINE_TALL,
		--loot        = function() return {"marble", math.random() < 0.5 and "marble" or "marblebean"} end,
		loot        = {"marble", "marble", "marblebean"},
	},
}

local function SetGrowth(inst)
	local new_size = inst.components.growable.stage
    inst.statedata = statedata[new_size]
    inst.AnimState:PlayAnimation(inst.statedata.idleanim)  
	inst.components.workable:SetWorkLeft(inst.statedata.workleft)
	inst.components.lootdropper:SetLoot(inst.statedata.loot)
end

local function DoGrow(inst)
    inst.AnimState:PlayAnimation(inst.statedata.growanim)
    --inst.SoundEmitter:PlaySound(inst.statedata.growsound)
    inst.AnimState:PushAnimation(inst.statedata.idleanim, false)
end

local GROWTH_STAGES =
{
    {
        time = function(inst) return GetRandomWithVariance(TUNING.MARBLESHRUB_GROW_TIME[1].base, TUNING.MARBLESHRUB_GROW_TIME[1].random) end,
        fn = function(inst) SetGrowth(inst) end,
        growfn = function(inst) DoGrow(inst) end,
    },
    {
        time = function(inst) return GetRandomWithVariance(TUNING.MARBLESHRUB_GROW_TIME[2].base, TUNING.MARBLESHRUB_GROW_TIME[2].random) end,
        fn = function(inst) SetGrowth(inst) end,
        growfn = function(inst) DoGrow(inst) end,
    },
    {
        time = function(inst) return GetRandomWithVariance(TUNING.MARBLESHRUB_GROW_TIME[3].base, TUNING.MARBLESHRUB_GROW_TIME[3].random) end,
        fn = function(inst) SetGrowth(inst) end,
        growfn = function(inst) DoGrow(inst) end,
    },
}

local function SetupShrubShape(inst, buildnum)
	inst.shapenumber = buildnum
	if inst.shapenumber ~= 1 then
		inst.AnimState:OverrideSymbol("marbleshrub_top1", "marbleshrub_build", "marbleshrub_top"..tostring(inst.shapenumber))
	end
end

local function GrowFromSeed(inst)
	SetupShrubShape(inst, math.random(NUM_BUILDS))
    local color = .5 + math.random() * .5
    inst.AnimState:SetMultColour(color, color, color, 1)
    inst.components.growable:SetStage(1)
    inst.AnimState:PlayAnimation("grow_seed_to_short")
    inst.AnimState:PushAnimation("idle_short", false)
    inst.SoundEmitter:PlaySound("dontstarve/common/together/marble_shrub/grow")
end

local function lootsetfn(lootdropper)
	local loot = lootdropper.inst.statedata.loot()
    lootdropper:SetLoot(loot)
end

local function onworked(inst, worker, workleft)
    if workleft > 0 then
		inst.AnimState:PlayAnimation(inst.statedata.hitanim)
    else
		inst.AnimState:PlayAnimation(inst.statedata.breakanim)
        --local pos = inst:GetPosition()
        --SpawnPrefab("rock_break_fx").Transform:SetPosition(pos:Get())
        --inst.components.lootdropper:DropLoot(pos)
		inst.SoundEmitter:PlaySound("dontstarve/wilson/rock_break")
		inst.components.lootdropper:DropLoot()	
		inst:AddComponent("workable")
		inst.components.workable:SetWorkAction(ACTIONS.DIG)
		inst.components.workable:SetWorkLeft(99)
		inst.components.workable.workable = false
		inst.persists = false
	    inst:ListenForEvent("animover", inst.Remove)
    end
end

local function onsave(inst, data)
	if inst.shapenumber ~= 1 then
	    data.shapenumber = inst.shapenumber
	end
    data.color = inst.AnimState:GetMultColour()
end

local function onload(inst, data)
    if data ~= nil then
		SetupShrubShape(inst, data.shapenumber or 1)
	    if data.color then
		    inst.AnimState:SetMultColour(data.color, data.color, data.color, 1)
		end
	end
end

local function onloadpostpass(inst)
    inst.statedata = statedata[inst.components.growable.stage]
end

local function MakeShrub(name, growthstage)
	growthstage = growthstage or 1
	local function fn()
		local inst = CreateEntity()
        inst:SetPrefabName("marbleshrub")

		inst.entity:AddTransform()
		inst.entity:AddAnimState()  
		inst.entity:AddSoundEmitter()

		MakeObstaclePhysics(inst, 0.1)

		local minimap = inst.entity:AddMiniMapEntity()
		minimap:SetIcon( "marbleshrub.tex" )

		inst.AnimState:SetBank("marbleshrub")
		inst.AnimState:SetBuild("marbleshrub")
		inst.AnimState:PlayAnimation("idle_short")

		inst:AddTag("boulder")

		inst.shapenumber = 1
		inst.statedata = statedata[growthstage]
		
		inst.growfromseed = GrowFromSeed

        inst:AddComponent("growable")
        inst.components.growable.stages = GROWTH_STAGES
        inst.components.growable.loopstages = true

		inst:AddComponent("lootdropper")
		--inst.components.lootdropper:SetLootSetupFn(lootsetfn)

		inst:AddComponent("inspectable")

		inst:AddComponent("workable")
		inst.components.workable:SetWorkAction(ACTIONS.MINE)
		inst.components.workable:SetWorkLeft(TUNING.MARBLESHRUB_MINE_SMALL)
		inst.components.workable:SetOnWorkCallback(onworked)

		MakeSnowCovered(inst)

		inst.OnSave = onsave
		inst.OnLoad = onload
		inst.OnLoadPostPass = onloadpostpass

        inst.components.growable:SetStage(growthstage)
        inst.components.growable:StartGrowing()
		return inst
	end	
	return Prefab(name, fn, assets, prefabs)
end

STRINGS.NAMES.MARBLESHRUB = "Marble Shrub"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.MARBLESHRUB = "Makes sense to me."
STRINGS.NAMES.MARBLESHRUB_SHORT = "Marble Shrub"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.MARBLESHRUB_SHORT = "Makes sense to me."
STRINGS.NAMES.MARBLESHRUB_NORMAL = "Marble Shrub"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.MARBLESHRUB_NORMAL = "Makes sense to me."
STRINGS.NAMES.MARBLESHRUB_TALL = "Marble Shrub"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.MARBLESHRUB_TALL = "Makes sense to me."

return MakeShrub("marbleshrub"),
       MakeShrub("marbleshrub_short", 1),
       MakeShrub("marbleshrub_normal", 2),
       MakeShrub("marbleshrub_tall", 3)