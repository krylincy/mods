require("brains/doydoypetbrain")
require "stategraphs/SGdoydoy"
require "behaviours/panic"

local KEYP1 = KEY_SPACE

local assets =
{
	Asset("ANIM", "anim/doydoypet_adult_tarn.zip"),
	Asset("ANIM", "anim/doydoypet_adult_default.zip"),
	Asset("ANIM", "anim/doydoypet_teen_tarn.zip"),
	Asset("ANIM", "anim/doydoypet_teen_default.zip"),
	Asset("ANIM", "anim/doydoypet_baby_tarn.zip"),
	Asset("ANIM", "anim/doydoypet_baby_default.zip"),
	
    Asset("ATLAS", "images/inventoryimages/doydoypet_adult_default.xml"),
    Asset("IMAGE", "images/inventoryimages/doydoypet_adult_default.tex"),
    Asset("ATLAS", "images/inventoryimages/doydoypet_adult_tarn.xml"),
    Asset("IMAGE", "images/inventoryimages/doydoypet_adult_tarn.tex"),
    Asset("ATLAS", "images/inventoryimages/doydoypet_baby_default.xml"),
    Asset("IMAGE", "images/inventoryimages/doydoypet_baby_default.tex"),
    Asset("ATLAS", "images/inventoryimages/doydoypet_baby_tarn.xml"),
    Asset("IMAGE", "images/inventoryimages/doydoypet_baby_tarn.tex"),
    Asset("ATLAS", "images/inventoryimages/doydoypet_teen_default.xml"),
    Asset("IMAGE", "images/inventoryimages/doydoypet_teen_default.tex"),
    Asset("ATLAS", "images/inventoryimages/doydoypet_teen_tarn.xml"),
    Asset("IMAGE", "images/inventoryimages/doydoypet_teen_tarn.tex"),
}

local prefabs_baby =
{
	"drumstick",
}

local prefabs =
{
	"drumstick",
	"doydoypetegg_cracked",
	"goldnugget",
}

local babyloot = {"butterfly"}
local teenloot = {"butterfly", "ash"}
local adultloot = {'butterfly', 'ash', 'ash'}

local babyfoodprefs = {"SEEDS"}
local teenfoodprefs = {"SEEDS"}
--local adultfoodprefs = {"SEEDS"}
local adultfoodprefs = {"VEGGIE", "SEEDS"}
local adultfoodprefs_female = {"VEGGIE", "SEEDS"}


local babysounds = 
{
	eat_pre = "dontstarve_DLC002/creatures/baby_doy_doy/eat_pre",
	swallow = "dontstarve_DLC002/creatures/teen_doy_doy/swallow",
	hatch = "dontstarve_DLC002/creatures/baby_doy_doy/hatch",
	death = "dontstarve_DLC002/creatures/baby_doy_doy/death",
	jump = "dontstarve_DLC002/creatures/baby_doy_doy/jump",
	peck = "dontstarve_DLC002/creatures/teen_doy_doy/peck",
}

local teensounds = 
{
	idle = "dontstarve_DLC002/creatures/teen_doy_doy/idle",
	eat_pre = "dontstarve_DLC002/creatures/teen_doy_doy/eat_pre",
	swallow = "dontstarve_DLC002/creatures/teen_doy_doy/swallow",
	hatch = "dontstarve_DLC002/creatures/teen_doy_doy/hatch",
	death = "dontstarve_DLC002/creatures/teen_doy_doy/death",
	jump = "dontstarve_DLC002/creatures/baby_doy_doy/jump",
	peck = "dontstarve_DLC002/creatures/teen_doy_doy/peck",
}


local function setColor(inst)
	if not inst.color then
		inst.color = 0.7 + math.random(0, 3) / 10
	end
		
	if inst:HasTag("doydoypet_female") then
		inst.AnimState:SetMultColour(1, 1, inst.color, 1)
	else
		inst.AnimState:SetMultColour(inst.color, 1, 1, 1)
	end
end

local function updateDescription(inst)
	local items = inst.components.inventory:FindItems(function(item) return inst.components.eater:CanEat(item) end)
	local inventoryItems = 0
	local lifespan = ''
	local sex = ' | M'
	
	if inst:HasTag("doydoypet_female") then
		 sex = ' | F'
	end

	
	if inst.eatTimes > 0 then
		lifespan = math.floor(inst.eatTimes / TUNING.DOYDOYPET_EAT_PER_DAY / TUNING.DOYDOYPET_DIE_OLD_AGE * 10)
	end	
	
	if #items > 0 then
		for index, data in ipairs(items) do
			--print(data.name)					
			
			if data.components.stackable ~= nil then
				inventoryItems = inventoryItems + data.components.stackable:StackSize()
				--print("stacksize: "..data.components.stackable:StackSize())
			else
				inventoryItems = inventoryItems + 1
			end
		end
		inventoryItems = ' | '..inventoryItems
	else
		inventoryItems = ' | 0'
	end
	
	inst.inventoryItems = inventoryItems
	
	inst.components.inspectable:SetDescription(lifespan.."0% of Lifespan"..sex..inst.inventoryItems)
end

local function OnEat(inst, food)		
	if inst.eatTimes == 0 then
		--print("First Eat")
		local chance = math.random()
		--print("Doydoypet female chance: "..chance)
		if chance < 0.25 then
			inst:AddTag("doydoypet_female")	
			inst.AnimState:SetBuild("doydoypet_baby_tarn")			
		end
		
		setColor(inst)
	end
	
	if food.components.edible.foodtype == "VEGGIE" then		
		if inst:HasTag("doydoypet_female") and inst:HasTag("adult") then	
			--SpawnPrefab("seeds_cooked").Transform:SetPosition(inst.Transform:GetWorldPosition())
			
			
			if math.random() < TUNING.DOYDOYPET_BREED_CHANCE then 
				SpawnPrefab("seeds_cooked").Transform:SetPosition(inst.Transform:GetWorldPosition())
				SpawnPrefab("doydoypetbaby").Transform:SetPosition(inst.Transform:GetWorldPosition())	
			end	
		else			
			if math.random() < 0.1 then
				SpawnPrefab("poop").Transform:SetPosition(inst.Transform:GetWorldPosition())
			end	
			if math.random() < 0.4 then
				SpawnPrefab("seeds_cooked").Transform:SetPosition(inst.Transform:GetWorldPosition())
			end	
			if math.random() < 0.8 then 
				inst.eatTimes = inst.eatTimes + 1
			end	
		end
	end
	
	inst.eatTimes = inst.eatTimes + 1
	updateDescription(inst)
end


local function SetBaby(inst)	
	inst:AddTag("baby")
	inst:RemoveTag("teen")	
	
	if inst:HasTag("doydoypet_female") then
		inst.AnimState:SetBuild("doydoypet_baby_tarn")
	else
		inst.AnimState:SetBuild("doydoypet_baby_default")
	end
	
	inst.AnimState:SetBank("doydoypet_baby")
	inst.AnimState:PlayAnimation("idle", true)
	setColor(inst)

	inst.sounds = babysounds
	--inst.components.combat:SetHurtSound("dontstarve_DLC002/creatures/baby_doy_doy/hit")

	inst.Transform:SetScale(1, 1, 1)

	inst.components.health:SetMaxHealth(TUNING.DOYDOYPET_BABY_HEALTH)
	inst.components.locomotor.walkspeed = TUNING.DOYDOYPET_BABY_WALK_SPEED
	inst.components.locomotor.runspeed = TUNING.DOYDOYPET_BABY_WALK_SPEED
	inst.components.lootdropper:SetLoot(babyloot)
	inst.components.eater.foodprefs = babyfoodprefs
	
	inst:ClearBufferedAction()

end

local function SetTeen(inst)
	inst:ClearBufferedAction()
	inst:AddTag("teen")
	inst:RemoveTag("baby")
	
	if inst:HasTag("doydoypet_female") then
		inst.AnimState:SetBuild("doydoypet_teen_tarn")
		inst.components.inventoryitem.atlasname = "images/inventoryimages/doydoypet_teen_tarn.xml"
		inst.components.inventoryitem.imagename = "doydoypet_teen_tarn"
	else
		inst.AnimState:SetBuild("doydoypet_teen_default")
		inst.components.inventoryitem.atlasname = "images/inventoryimages/doydoypet_teen_default.xml"
		inst.components.inventoryitem.imagename = "doydoypet_teen_default"
	end

	inst.AnimState:SetBank("doydoypet")
	inst.AnimState:PlayAnimation("idle", true)
	setColor(inst)
	
	inst.sounds = teensounds
	--inst.components.combat:SetHurtSound("dontstarve_DLC002/creatures/doy_doy/hit")

	local scale = TUNING.DOYDOY_TEEN_SCALE
	inst.Transform:SetScale(scale, scale, scale)

	inst.components.health:SetMaxHealth(TUNING.DOYDOYPET_TEEN_HEALTH)
	inst.components.locomotor.walkspeed = TUNING.DOYDOYPET_TEEN_WALK_SPEED
	inst.components.locomotor.runspeed = TUNING.DOYDOYPET_TEEN_WALK_SPEED
	inst.components.lootdropper:SetLoot(teenloot)
	inst.components.eater.foodprefs = teenfoodprefs
	
	inst:ClearBufferedAction()
end

local function SetFullyGrown(inst)
	inst:ClearBufferedAction()
	inst:AddTag("adult")
	inst:RemoveTag("teen")

	if inst:HasTag("doydoypet_female") then
		inst.AnimState:SetBuild("doydoypet_adult_tarn")
		inst.components.inventoryitem.atlasname = "images/inventoryimages/doydoypet_adult_tarn.xml"
		inst.components.inventoryitem.imagename = "doydoypet_adult_tarn"
		inst.components.eater.foodprefs = adultfoodprefs_female	
	else
		inst.AnimState:SetBuild("doydoypet_adult_default")
		inst.components.inventoryitem.atlasname = "images/inventoryimages/doydoypet_adult_default.xml"
		inst.components.inventoryitem.imagename = "doydoypet_adult_default"
		inst.components.eater.foodprefs = adultfoodprefs
	end
	
	inst.AnimState:SetBank("doydoypet")
	inst.AnimState:PlayAnimation("idle", true)
	setColor(inst)

	--inst.components.combat:SetHurtSound("dontstarve_DLC002/creatures/doy_doy/hit")

	local scale = 1
	inst.Transform:SetScale(scale, scale, scale)

	inst.components.health:SetMaxHealth(TUNING.DOYDOYPET_HEALTH)
	inst.components.locomotor.walkspeed = TUNING.DOYDOYPET_WALK_SPEED
	inst.components.locomotor.runspeed = TUNING.DOYDOYPET_WALK_SPEED
	inst.components.lootdropper:SetLoot(adultloot)
	
	inst.components.growable:StopGrowing()

	
	
	inst:ClearBufferedAction()
end

local function GetBabyGrowTime()
	return 10
end

local function GetTeenGrowTime()
	return 10
end

local growth_stages =
{
	{name="baby", time = GetBabyGrowTime, fn = SetBaby},
	{name="teen", time = GetTeenGrowTime, fn = SetTeen},
	{name="grown", time = GetTeenGrowTime, fn = SetFullyGrown},
}

local function OnEntitySleep(inst)
	inst:ClearBufferedAction()	
end


local function OnEntityWake(inst)
	inst:ClearBufferedAction()	
end

local function onsave(inst, data)
	data.eatTimes = inst.eatTimes
	data.color = inst.color
	data.inventoryItems = inst.inventoryItems
	data.female = inst:HasTag("doydoypet_female")
end

local function onload(inst, data)
    if data and data.eatTimes then
		inst.eatTimes = data.eatTimes
	end     
	
	if data and data.inventoryItems then
		inst.inventoryItems = data.inventoryItems
	end   
	
	if data and data.color then
		inst.color = data.color
	end
	
	if data and data.female then
		inst:AddTag("doydoypet_female")
	end
end

local function ShouldAcceptItem(inst, item)
    if item.components.edible and inst.components.eater:CanEat(item) then
        return true
    end
end

local function OnGetItemFromPlayer(inst, giver, item)	
	inst:ClearBufferedAction()
	
    if inst.components.sleeper:IsAsleep() then
        inst.components.sleeper:WakeUp()
    end
	inst.SoundEmitter:PlaySound(inst.sounds.peck)
	updateDescription(inst)
end

local function OnRefuseItem(inst, item)
    if inst.components.sleeper:IsAsleep() then
        inst.components.sleeper:WakeUp()
    end
	inst.SoundEmitter:PlaySound("dontstarve/common/dust_blowaway")
    inst:PushEvent("refuseitem")
end


local function commonfn(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	local sound = inst.entity:AddSoundEmitter()
	local shadow = inst.entity:AddDynamicShadow()	
	
	inst.eatTimes = 0	


	shadow:SetSize(1.5, 0.8)	
	inst.Transform:SetFourFaced()	
	MakeCharacterPhysics(inst, 1, .25)
	
	inst.AnimState:SetBank("doydoypet")
	inst.AnimState:PlayAnimation("idle", true)
	setColor(inst)
	
	inst:AddTag("doydoypet")
	inst:AddTag("noautopickup")
	
	inst:AddComponent("health")
	--inst:AddComponent("combat")
	inst:AddComponent("sizetweener")
	inst:AddComponent("sleeper")
	inst:AddComponent("lootdropper")
	inst:AddComponent("knownlocations")
	inst:AddComponent("talker")
	
	inst:ListenForEvent("entitysleep", OnEntitySleep)
	inst:ListenForEvent("entitywake", OnEntityWake)

	MakeSmallBurnableCharacter(inst, "swap_fire")
	MakeSmallFreezableCharacter(inst, "mossling_body")

	inst:AddComponent("locomotor")
	
	inst:AddComponent("named")   
	inst:AddComponent("inspectable")
	
	inst.components.named.possiblenames = STRINGS.BUNNYMANNAMES
    inst.components.named:PickNewName()	
	
	inst:AddComponent("eater")
    inst.components.eater:SetVegetarian()
    inst.components.eater:SetOnEatFn(OnEat)
    inst:ListenForEvent("oneatsomething", function(inst, data) updateDescription(inst) end)
	
	inst:AddComponent("inventory")
	updateDescription(inst)
	
	inst:AddComponent("trader")
    inst.components.trader:SetAcceptTest(ShouldAcceptItem)
    inst.components.trader.onaccept = OnGetItemFromPlayer
    inst.components.trader.onrefuse = OnRefuseItem
    inst.components.trader:Enable()

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.nobounce = true
    inst.components.inventoryitem.canbepickedup = false
    inst.components.inventoryitem.longpickup = true	
	
	if inst:HasTag("doydoypet_female") then
		inst.AnimState:SetBuild("doydoypet_adult_tarn")
		inst.components.inventoryitem.atlasname = "images/inventoryimages/doydoypet_adult_tarn.xml"
		inst.components.inventoryitem.imagename = "doydoypet_adult_tarn"
	else
		inst.AnimState:SetBuild("doydoypet_adult_default")
		inst.components.inventoryitem.atlasname = "images/inventoryimages/doydoypet_adult_default.xml"
		inst.components.inventoryitem.imagename = "doydoypet_adult_default"
	end

    inst:ListenForEvent("ondropped", function(inst, data)
        inst.components.knownlocations:RememberLocation("home", Point(inst.Transform:GetWorldPosition()), false)
		if inst.components.sleeper:IsAsleep() then
			inst.components.sleeper:WakeUp()
		end
    end)
	
	inst:ListenForEvent("gotosleep", function(inst) inst.components.inventoryitem.canbepickedup = true end)
    inst:ListenForEvent("onwakeup", function(inst) inst.components.inventoryitem.canbepickedup = false end)

	
	inst.OnSave = onsave --set the save
	inst.OnLoad = onload --and the load functions
	    
	return inst
end

local function babyfn(Sim)
	local inst = commonfn(Sim)
	
	if inst:HasTag("doydoypet_female") then
		inst.AnimState:SetBuild("doydoypet_baby_tarn")
		inst.components.inventoryitem.atlasname = "images/inventoryimages/doydoypet_baby_tarn.xml"
		inst.components.inventoryitem.imagename = "doydoypet_baby_tarn"
	else
		inst.AnimState:SetBuild("doydoypet_baby_default")
		inst.components.inventoryitem.atlasname = "images/inventoryimages/doydoypet_baby_default.xml"
		inst.components.inventoryitem.imagename = "doydoypet_baby_default"
	end

	inst.AnimState:SetBank("doydoypet_baby")
	inst.AnimState:PlayAnimation("idle", true)
	setColor(inst)

	inst:AddTag("baby")

	inst.sounds = babysounds
	
	--inst.components.combat:SetHurtSound("dontstarve_DLC002/creatures/baby_doy_doy/hit")
	
	inst.components.health:SetMaxHealth(TUNING.DOYDOYPET_BABY_HEALTH)
	inst.components.locomotor.walkspeed = TUNING.DOYDOYPET_BABY_WALK_SPEED
	inst.components.locomotor.runspeed = TUNING.DOYDOYPET_BABY_WALK_SPEED
	inst.components.lootdropper:SetLoot(babyloot)

	inst.components.eater.foodprefs = babyfoodprefs

	inst:SetStateGraph("SGdoydoybaby")
	local brain = require("brains/doydoypetbrain")
	inst:SetBrain(brain)

	inst:AddComponent("growable")
	inst.components.growable.stages = growth_stages
	inst.components.growable:SetStage(1)
	inst.components.growable.growoffscreen = true
	inst.components.growable:StartGrowing()	

	return inst
end

local function adultfn(Sim)
	local inst = commonfn(Sim)

	if inst:HasTag("doydoypet_female") then
		inst.AnimState:SetBuild("doydoypet_adult_tarn")
		inst.components.inventoryitem.atlasname = "images/inventoryimages/doydoypet_adult_tarn.xml"
		inst.components.inventoryitem.imagename = "doydoypet_adult_tarn"
		inst.components.eater.foodprefs = adultfoodprefs_female	
	else
		inst.AnimState:SetBuild("doydoypet_adult_default")
		inst.components.inventoryitem.atlasname = "images/inventoryimages/doydoypet_adult_default.xml"
		inst.components.inventoryitem.imagename = "doydoypet_adult_default"
		inst.components.eater.foodprefs = adultfoodprefs
	end
	
	setColor(inst)

	inst.AnimState:SetBank("doydoypet")
	inst.AnimState:PlayAnimation("idle", true)

	--inst.components.combat:SetHurtSound("dontstarve_DLC002/creatures/doy_doy/hit")

	inst.components.health:SetMaxHealth(TUNING.DOYDOYPET_HEALTH)
	inst.components.locomotor.walkspeed = TUNING.DOYDOYPET_WALK_SPEED
	inst.components.lootdropper:SetLoot(adultloot)
	
	inst:SetStateGraph("SGdoydoy")
	local brain = require("brains/doydoypetbrain")
	inst:SetBrain(brain)

	return inst
end


return  Prefab("common/monsters/doydoypetbaby", babyfn, assets, prefabs_baby),
		Prefab("common/monsters/doydoypet", adultfn, assets, prefabs)
