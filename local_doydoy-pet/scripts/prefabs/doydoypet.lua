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
local adultfoodprefs = {"VEGGIE", "SEEDS"}


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

local function setPresentation(inst, typ)
	inst.AnimState:SetBuild("doydoypet_"..typ)
	inst.components.inventoryitem.atlasname = "images/inventoryimages/doydoypet_"..typ..".xml"
	inst.components.inventoryitem.imagename = "doydoypet_"..typ
end

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
		if chance < TUNING.DOYDOYPET_FEMALE_CHANCE then --0.25
			inst:AddTag("doydoypet_female")			
		end

		if inst:HasTag("doydoypet_female") then
			setPresentation(inst, "baby_tarn")	
		end

		if not inst:HasTag("hasWidgetCount") then
			if inst:HasTag("doydoypet_female") then
				-- can be female from hatch
				GetWorld().components.doydoypet:ChangeCounterFemale(1)
			else
				GetWorld().components.doydoypet:ChangeCounterMale(1)	
			end
			inst:AddTag("hasWidgetCount")
		end
		
		setColor(inst)
	end

	if food.components.edible.foodtype == "VEGGIE" then		
		if inst:HasTag("doydoypet_female") and inst:HasTag("adult") then	
			--SpawnPrefab("seeds_cooked").Transform:SetPosition(inst.Transform:GetWorldPosition())
			
			local chance = math.random()
			if chance < TUNING.DOYDOYPET_BREED_CHANCE then 
				SpawnPrefab("seeds_cooked").Transform:SetPosition(inst.Transform:GetWorldPosition())
				SpawnPrefab("doydoypetbaby").Transform:SetPosition(inst.Transform:GetWorldPosition())	
			end	
		else			
			if math.random() < 0.2 then
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
		setPresentation(inst, "baby_tarn")
	else
		setPresentation(inst, "baby_default")
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
		setPresentation(inst, "teen_tarn")
	else
		setPresentation(inst, "teen_default")
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
		setPresentation(inst, "adult_tarn")
	else
		setPresentation(inst, "adult_default")	
	end

	inst.components.eater.foodprefs = adultfoodprefs
	
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

local function OnDeath(inst)
	print("doydoypet OnDeath", inst:HasTag("hasWidgetCount"))

	if inst:HasTag("hasWidgetCount") then
		if inst:HasTag("doydoypet_female") then
			GetWorld().components.doydoypet:ChangeCounterFemale(-1)
		else
			GetWorld().components.doydoypet:ChangeCounterMale(-1)	
		end
	end
end

local function onsave(inst, data)
	data.eatTimes = inst.eatTimes
	data.color = inst.color
	data.inventoryItems = inst.inventoryItems
	data.female = inst:HasTag("doydoypet_female")
	data.hasWidgetCount = inst:HasTag("hasWidgetCount")
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

		if inst:HasTag("baby") then
			setPresentation(inst, "baby_tarn")
		elseif inst:HasTag("teen") then
			setPresentation(inst, "teen_tarn")
		else
			setPresentation(inst, "adult_tarn")
		end
	elseif data then
		if inst:HasTag("baby") then
			setPresentation(inst, "baby_default")
		elseif inst:HasTag("teen") then
			setPresentation(inst, "teen_default")
		else
			setPresentation(inst, "adult_default")
		end
	end

	if data and not data.hasWidgetCount then
		if inst.eatTimes > 0 then
			if inst:HasTag("doydoypet_female") then
				GetWorld().components.doydoypet:ChangeCounterFemale(1)
			else
				GetWorld().components.doydoypet:ChangeCounterMale(1)
			end
			inst:AddTag("hasWidgetCount")
		end
	end  

	if data and data.hasWidgetCount then
		inst:AddTag("hasWidgetCount")
	end
end

local function ShouldAcceptItem(inst, item)
    if item.components.edible and inst.components.eater:CanEat(item) then
        return true
    end
end

local function OnGetItemFromPlayer(inst, giver, item)	
	if inst.components.sleeper:IsAsleep() then
        inst.components.sleeper:WakeUp()
    end

	inst:ClearBufferedAction()
	inst.sg:GoToState("idle")	
   
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

local function ondropped(inst)
	if inst.components.sleeper:IsAsleep() then
        inst.components.sleeper:WakeUp()
    end
    inst:ClearBufferedAction()
	inst.sg:GoToState("idle")	
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
	inst.components.health.canmurder = false
	--inst:AddComponent("combat")
	inst:AddComponent("sizetweener")
	inst:AddComponent("sleeper")
	inst:AddComponent("lootdropper")
	inst:AddComponent("knownlocations")
	inst:AddComponent("talker")

	inst:ListenForEvent("death", OnDeath)
	
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
	inst.components.inventoryitem:SetOnDroppedFn(ondropped)
    inst.components.inventoryitem.nobounce = true
    inst.components.inventoryitem.canbepickedup = false
	
	if inst:HasTag("doydoypet_female") then
		setPresentation(inst, "adult_tarn")
	else
		setPresentation(inst, "adult_default")
	end

    inst:ListenForEvent("ondropped", function(inst, data)
        inst.components.knownlocations:RememberLocation("home", Point(inst.Transform:GetWorldPosition()), false)
		inst.components.sleeper:WakeUp()
    end)
	
	inst:ListenForEvent("gotosleep", function(inst) inst.components.inventoryitem.canbepickedup = true end)
    inst:ListenForEvent("onwakeup", function(inst) inst.components.inventoryitem.canbepickedup = false end)

	--MakeFeedablePet(inst, TUNING.TOTAL_DAY_TIME/2)

	
	inst.OnSave = onsave --set the save
	inst.OnLoad = onload --and the load functions
	    
	return inst
end

local function babyfn(Sim)
	local inst = commonfn(Sim)
	
	if inst:HasTag("doydoypet_female") then
		setPresentation(inst, "baby_tarn")
	else
		setPresentation(inst, "baby_default")
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
		setPresentation(inst, "adult_tarn")
	else
		setPresentation(inst, "adult_default")	
	end

	inst.components.eater.foodprefs = adultfoodprefs
	
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
