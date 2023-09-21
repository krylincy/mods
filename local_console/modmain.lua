STRINGS = GLOBAL.STRINGS
RECIPETABS = GLOBAL.RECIPETABS
Recipe = GLOBAL.Recipe
RECIPE_GAME_TYPE = GLOBAL.RECIPE_GAME_TYPE
Ingredient = GLOBAL.Ingredient
TECH = GLOBAL.TECH
ACTIONS = GLOBAL.ACTIONS
SpawnPrefab = GLOBAL.SpawnPrefab
GetPlayer = GLOBAL.GetPlayer
GetWorld = GLOBAL.GetWorld
GetString = GLOBAL.GetString
GetClock = GLOBAL.GetClock
Vector3 = GLOBAL.Vector3
EQUIPSLOTS = GLOBAL.EQUIPSLOTS
Lerp = GLOBAL.Lerp

-- min spacing mod
for _,v in pairs(GLOBAL.GetAllRecipes()) do
    v.min_spacing = 1
end

local function customSimPostInit(inst) 
    GLOBAL.TheCamera:SetDistance(40)
 end



local function custom_tuning()
    local total_day_time = 30 * 16

    TUNING.EFFIGY_HEALTH_PENALTY = 0
    TUNING.RESURRECT_HEALTH = 300
    TUNING.BERRY_REGROW_INCREASE = 0
    TUNING.BERRY_REGROW_TIME = total_day_time
    TUNING.FLOWER_CAVE_REGROW_TIME = total_day_time

    TUNING["STACK_SIZE_LARGEITEM"] = 10000
    TUNING["STACK_SIZE_MEDITEM"] = 10000
    TUNING["STACK_SIZE_SMALLITEM"] = 10000
    -- TUNING.WILSON_WALK_SPEED = 5
    -- TUNING.WILSON_RUN_SPEED = 9

    -- WILSON_HUNGER_RATE = calories_per_day/total_day_time, --calories burnt per day
    local stormachSize = 250
    TUNING.WILSON_HUNGER_RATE = 200 / 480 -- default: 75/480
    TUNING.WILSON_HUNGER = stormachSize
    TUNING.WALANI_HUNGER = stormachSize
    TUNING.WATHGRITHR_HUNGER = stormachSize 
    TUNING.WILBA_HUNGER = stormachSize

    TUNING.PIPE_DART_DAMAGE = 400 -- to onehit terrorbreak
    TUNING.TORNADOSTAFF_USES = 500
    -- TUNING.TORNADO_DAMAGE = 100
    TUNING.ARMORRUINS_ABSORPTION = 1 -- 100%
    TUNING.ARMOR_RUINSHAT_ABSORPTION = 1 -- 100%

    TUNING.ABIGAIL_SPEED = 9
    TUNING.ABIGAIL_DAMAGE_PER_SECOND = 80

    TUNING.ORANGEAMULET_USES = 5000
    TUNING.ORANGEAMULET_RANGE = 20
    TUNING.ORANGEAMULET_ICD = 0.15

    TUNING.BERRYBUSH_CYCLES = 1000 -- pickable before barren
    TUNING.BOAT_REPAIR_KIT_USES = 20
    TUNING.SEWINGKIT_USES = 20
    TUNING.FERTILIZER_USES = 30

    TUNING.FOOD_SPEED_LONG = total_day_time + 10 -- coffee effects

    TUNING.WORMLIGHT_DURATION = 60 * 8
    TUNING.WORMLIGHT_RADIUS = 15
    -- TUNING.WALLHAY_WINDBLOWN_DAMAGE = 0 
    -- TUNING.WALLWOOD_WINDBLOWN_DAMAGE = 0 

    -- local world = GetWorld()
    -- if world.components.cityalarms then
    -- world:RemoveComponent("cityalarms") 		
    -- end    
end

function shopinteriorOverwrite(self, inst)
    -- Available prices: [1, 2, 3, 4, 5, 10, 20, 30, 40, 50, 100, 200, 300, 400, 500]
    local SHOPTYPES = {
        ["pig_shop_cityhall"] = {},
        ["DEFAULT"] = {"rocks", "flint", "goldnugget"},
        ["pig_shop_deli"] = {{"coffee", "oinc", 2}, 
                            --  {"coffee", "oinc", 2},
                            --  {"coffee", "oinc", 2},
                             {"coffee", "oinc", 2},
                             {"taffy", "oinc", 5},
                             {"tropicalbouillabaisse", "oinc", 5},
                             {"lobsterdinner", "oinc", 10},
                             {"freshfruitcrepes", "oinc", 20}},
        ["pig_shop_florist"] = {{"acorn", "oinc", 2}, 
                                {"pinecone", "oinc", 2},
                                {"burr", "oinc", 2}, 
                                {"teatree_nut", "oinc", 2},
                                {"jungletreeseed", "oinc", 2},
                                -- {"dug_sapling", "oinc", 4},
                                {"dug_berrybush2", "oinc", 30}},
        ["pig_shop_general"] = {{"bandage", "oinc", 3},
                                {"antivenom", "oinc", 5},
                                {"multitool_axe_pickaxe", "oinc", 50},
                                {"orangeamulet", "oinc", 50},
                                -- {"blueprint", "oinc", 100},
                                -- {"cutstone", "oinc", 1}, 
                                -- {"tunacan", "oinc", 2},
                                {"tunacan", "oinc", 2},
                                {"tunacan", "oinc", 2},
                                {"tunacan", "oinc", 2}},
        ["pig_shop_hoofspa"] = {{"thulecite", "oinc", 5}, 
                                {"iron", "oinc", 1},
                                -- {"nitre", "oinc", 1},
                                {"houndstooth", "oinc", 1},
                                {"stinger", "oinc", 1}, 
                                {"boneshard", "oinc", 1}},
        ["pig_shop_produce"] = {{"cave_banana", "oinc", 1},
                                {"mandrake", "oinc", 20},
                                {"coconut", "oinc", 1},
                                {"venus_stalk", "oinc", 5},
                                {"waterdrop", "oinc", 300},
                                {"honeycomb", "oinc", 5},
                                {"wormlight", "oinc", 20}},
        ["pig_shop_antiquities"] = {{"cutreeds", "oinc", 1},
                                    {"cutreeds", "oinc", 1},
                                    {"pigskin", "oinc", 2},
                                    {"pigskin", "oinc", 2},
                                    {"fabric", "oinc", 2},
                                    {"silk", "oinc", 1},
                                    {"livinglog", "oinc", 10},
                                    -- {"lightbulb", "oinc", 2},
                                    {"beefalowool", "oinc", 1}},
        ["pig_shop_arcane"] = {{"kingfisher", "oinc", 10},
                               {"rabbit", "oinc", 5}, 
                               {"butterfly", "oinc", 1},
                               {"butterfly", "oinc", 1},
                               {"butterfly", "oinc", 1},
                               {"fireflies", "oinc", 3},
                               {"bioluminescence", "oinc", 3}},
        ["pig_shop_weapons"] = {{"ruinshat", "oinc", 20},
                                {"armorruins", "oinc", 20},
                                {"cutlass", "oinc", 20},
                                {"blowdart_pipe", "oinc", 10},
                                {"blowdart_pipe", "oinc", 10},
                                {"blowdart_pipe", "oinc", 10}},
        ["pig_shop_hatshop"] = {{"brainjellyhat", "oinc", 100},
                                {"blubbersuit", "oinc", 20},
                                {"beargervest", "oinc", 20},
                                {"hawaiianshirt", "oinc", 20},
                                {"pithhat", "oinc", 10},
                                -- {"gasmaskhat", "oinc", 20},
                                {"armor_windbreaker", "oinc", 20},
                                {"double_umbrellahat", "oinc", 40}},
        ["pig_shop_bank"] = {{"goldnugget", "oinc", 20}, {"oinc10", "oinc", 10},
                             {"oinc100", "oinc", 100}},
        ["pig_shop_tinker"] = {{"turf_meadow", "oinc", 1},
                               {"turf_fields", "oinc", 1},
                               {"turf_lawn", "oinc", 1}},
        ["pig_shop_academy"] = {}
    }

    function self:GetNewProduct(shoptype)
        local items = SHOPTYPES[shoptype]
        if items then
            local itemset = GLOBAL.GetRandomItem(items)
            return itemset
        end
    end

    function self:MakeShop(numItems, shopType)
        local x, y, z = self.inst.Transform:GetWorldPosition()
        self.shopType = shopType
        if SHOPTYPES[shopType] then
            self.items = SHOPTYPES[shopType]
            self:FillPedestals(numItems, shopType)
        end
    end
end

function economyOverwrite(self, inst)
    local TRADER = {
        pigman_collector = {
            items = {"hippo_antler", "bill_quill", "tallbirdegg", "horn",
                     "dragoonheart", "lureplantbulb", "tigereye",
                     "spidereggsack", "shark_fin", "turbine_blades", "snakeoil",
                     "shark_gills", "magic_seal", "earring"},
            delay = 0,
            reset = 0,
            current = 0,
            desc = STRINGS.CITY_PIG_COLLECTOR_TRADE,
            reward = "oinc",
            rewardqty = 15
        },
        pigman_banker = {
            items = {"redgem", "bluegem", "greengem", "orangegem", "yellowgem"},
            delay = 0,
            reset = 0,
            current = 0,
            desc = STRINGS.CITY_PIG_BANKER_TRADE,
            reward = "oinc",
            rewardqty = 20
        },
        pigman_beautician = {
            items = {"feather_crow", "feather_robin", "feather_robin_winter",
                     "peagawkfeather", "feather_thunder", "doydoyfeather"},
            delay = 0,
            reset = 0,
            current = 0,
            desc = STRINGS.CITY_PIG_BEAUTICIAN_TRADE,
            reward = "oinc",
            rewardqty = 3
        },
        pigman_mechanic = {
            items = {"boards", "rope", "cutstone", "papyrus"},
            delay = 0,
            reset = 1,
            current = 0,
            desc = STRINGS.CITY_PIG_MECHANIC_TRADE,
            reward = "oinc",
            rewardqty = 2
        },
        pigman_professor = {
            items = {"relic_1", "relic_2", "relic_3", "bandithat"},
            delay = 0,
            reset = 0,
            current = 0,
            desc = STRINGS.CITY_PIG_PROFESSOR_TRADE,
            reward = "oinc",
            rewardqty = 10
        },
        pigman_hunter = {
            items = {"houndstooth", "stinger"},
            delay = 0,
            reset = 0,
            current = 0,
            desc = STRINGS.CITY_PIG_HUNTER_TRADE,
            reward = "oinc",
            rewardqty = 1
        },
        pigman_mayor = {
            items = {"goldnugget"},
            delay = 0,
            reset = 0,
            current = 0,
            desc = STRINGS.CITY_PIG_MAYOR_TRADE,
            reward = "oinc",
            rewardqty = 5
        },
        pigman_florist = {
            items = {"petals"},
            delay = 0,
            reset = 0,
            current = 0,
            desc = STRINGS.CITY_PIG_FLORIST_TRADE,
            reward = "oinc",
            rewardqty = 1
        },
        pigman_storeowner = {
            items = {"clippings", "waxpaper"},
            delay = 0,
            reset = 0,
            current = 0,
            desc = STRINGS.CITY_PIG_STOREOWNER_TRADE,
            reward = "oinc",
            rewardqty = 1
        },
        pigman_farmer = {
            items = {"cutgrass", "twigs"},
            delay = 0,
            reset = 1,
            current = 0,
            desc = STRINGS.CITY_PIG_FARMER_TRADE,
            reward = "oinc",
            rewardqty = 1
        },
        pigman_miner = {
            items = {"rocks"},
            delay = 0,
            reset = 1,
            current = 0,
            desc = STRINGS.CITY_PIG_MINER_TRADE,
            reward = "oinc",
            rewardqty = 1
        },
        pigman_erudite = {
            items = {"nightmarefuel"},
            delay = 0,
            reset = 0,
            current = 0,
            desc = STRINGS.CITY_PIG_ERUDITE_TRADE,
            reward = "oinc",
            rewardqty = 5
        },
        pigman_hatmaker = {
            items = {"silk"},
            delay = 0,
            reset = 1,
            current = 0,
            desc = STRINGS.CITY_PIG_HATMAKER_TRADE,
            reward = "oinc",
            rewardqty = 1
        },
        pigman_queen = {
            items = {"pigcrownhat", "pig_scepter", "relic_4", "relic_5"},
            delay = 0,
            reset = 0,
            current = 0,
            desc = STRINGS.CITY_PIG_QUEEN_TRADE,
            reward = "pedestal_key",
            rewardqty = 1
        },
        pigman_usher = {
            items = {"honey", "jammypreserves", "icecream", "pumpkincookie",
                     "waffles", "berries", "berries_cooked"},
            delay = 0,
            reset = 0,
            current = 0,
            desc = STRINGS.CITY_PIG_USHER_TRADE,
            reward = "oinc",
            rewardqty = 1
        }
    }

    for i = 1, GLOBAL.NUM_TRINKETS do
        table.insert(TRADER.pigman_collector.items, "trinket_" .. i)
    end

    function self:GetTradeItems(traderprefab)
        if TRADER[traderprefab] then
            return TRADER[traderprefab].items
        end
    end
    function self:GetTradeItemDesc(traderprefab)
        if not TRADER[traderprefab] then
            return nil
        end
        return TRADER[traderprefab].desc
    end

    function self:MakeTrade(traderprefab, city, inst)
        self.cities[city][traderprefab].GUIDS[inst.GUID] =
            TRADER[traderprefab].reset

        return TRADER[traderprefab].reward, TRADER[traderprefab].rewardqty
    end

    function self:AddCity(city)
        self.cities[city] = {}

        for traderprefab, data in pairs(TRADER) do
            self.cities[city][traderprefab] = {
                GUIDS = {}
            }
        end
    end
end

AddPrefabPostInit("gashat", function(inst) inst:AddTag("gasmask") end)
AddPrefabPostInit("grass", function(inst)
    local function ontransplantfn(inst)
        if inst.components.pickable then
            inst.components.pickable:MakeEmpty()
        end
    end

    inst.components.pickable.ontransplantfn = ontransplantfn
    inst.components.pickable.max_cycles = 100
    inst.components.pickable.cycles_left = 100
end)

local berrybushes = {"berrybush", "berrybush2"}
for _, prefabName in ipairs(berrybushes) do
    AddPrefabPostInit(prefabName, function(inst)
        local function ontransplantfn(inst)
            if inst.components.pickable then
                inst.components.pickable:MakeEmpty()
            end
        end
    
        inst.components.pickable.ontransplantfn = ontransplantfn
        inst.components.pickable:SetUp("berries", GLOBAL.TUNING.BERRY_REGROW_TIME, 10)
    end)
end

local fireImmunePrefabs = {"bush_vine", "bambootree", "reeds", "reeds_water", "beebox", "cookpot", "slow_farmplot", "fast_farmplot", "grass", "grass_tall", "sapling", "flower_cave", "flower_cave_double", "flower_cave_triple", "nettle", "fence", "fence_gate", "wall_wood", "plant_normal", "hedge", "berrybush", "berrybush2", "honeycomb", "red_mushroom", "blue_mushroom", "green_mushroom"}
for _, prefabName in ipairs(fireImmunePrefabs) do
    AddPrefabPostInit(prefabName, function(inst) inst:AddTag("fireimmune") end)
end

local noAutoPickupPrefabs = {"glommerflower", "chester_eyebone", "packim_fishbone", "ro_bin_gizzard_stone", "roc_robin_egg", "clippings", "berries", "seeds_cooked", "corn", "corn_cooked", "seatrap", "lantern", "powcake"}
for _, prefabName in ipairs(noAutoPickupPrefabs) do
    AddPrefabPostInit(prefabName, function(inst) inst:AddTag("noautopickup") end)
end

local heavyPrefabs = {"clippings", "berries", "seeds_cooked", "corn", "corn_cooked"}
for _, prefabName in ipairs(heavyPrefabs) do
    AddPrefabPostInit(prefabName, function(inst) GLOBAL.MakeBlowInHurricane(inst, 0.00001, 0.00002) -- HEAVY
     end)
end


AddPrefabPostInit("flower",
    function(inst) inst:RemoveComponent("blowinwindgust") end)
AddPrefabPostInit("flower_evil",
    function(inst) inst:RemoveComponent("blowinwindgust") end)
AddPrefabPostInit("rock_flippable",
    function(inst) inst:RemoveComponent("workable") end)

AddPrefabPostInit("tentaclespike", function(inst) inst:AddTag("burnable") end)

AddPrefabPostInit("multitool_axe_pickaxe", function(inst)
    -- inst:RemoveComponent("finiteuses") 
    inst.components.tool:SetAction(ACTIONS.DISLODGE, 20)
    inst.components.tool:SetAction(ACTIONS.DISARM, 20)
    inst.components.tool:SetAction(ACTIONS.CHOP, 20)
    inst.components.tool:SetAction(ACTIONS.MINE, 20)
    inst.components.tool:SetAction(ACTIONS.HACK, 20)
    inst.components.tool:SetAction(ACTIONS.SHEAR, 20)
    -- inst.components.tool:SetAction(ACTIONS.DIG, 10)
    -- inst.components.tool:SetAction(ACTIONS.HAMMER)
    inst:AddComponent("dislodger")
    inst:AddComponent("disarming")
end)
AddPrefabPostInit("lightbulb", function(inst)
    local function ondeploy(inst, pt, deployer)
        local sapling = SpawnPrefab("flower_cave_triple")
        sapling.Transform:SetPosition(pt:Get())
        sapling.SoundEmitter:PlaySound("dontstarve/wilson/plant_tree")
        inst:Remove()
    end

    inst:RemoveComponent("edible")
    inst:RemoveComponent("perishable")

    inst:AddComponent("deployable")
    inst.components.deployable.ondeploy = ondeploy	
    inst.components.deployable.placer = "marblebean_placer"
end)

AddPrefabPostInit("flower_cave_triple", function(inst)
    local function digup(inst, digger)
        inst:Remove()
    end

    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.DIG)
    inst.components.workable:SetOnFinishCallback(digup)
    inst.components.workable:SetWorkLeft(1)
end)

local mushroomColors = {"red", "green", "blue"}
for _, color in ipairs(mushroomColors) do
    AddPrefabPostInit(color.."_cap", function(inst) 
        local function ondeploy(inst, pt, deployer)
            local sapling = SpawnPrefab(color.."_mushroom")
            sapling.Transform:SetPosition(pt:Get())
            sapling.SoundEmitter:PlaySound("dontstarve/wilson/plant_tree")
            inst:Remove()
        end

        inst:AddTag("noautopickup")
        inst:AddComponent("deployable")
        inst.components.deployable.ondeploy = ondeploy	
        inst.components.deployable.placer = "marblebean_placer"
        inst.components.deployable.min_spacing = .5
    end)
    AddPrefabPostInit(color.."_cap_cooked", function(inst) 
        inst:AddTag("noautopickup")
    end)
end

AddPrefabPostInit("coffee", function(inst)
	inst.components.perishable:SetPerishTime(480000) -- 1000 days
end)

AddPrefabPostInit("healingsalve",
    function(inst) inst.components.healer:SetHealthAmount(60) end)
AddPrefabPostInit("bandage",
    function(inst) inst.components.healer:SetHealthAmount(60) end)
AddPrefabPostInit("wormlight",
    function(inst) inst.components.fuel.fueltype = "CAVE" end)
AddPrefabPostInit("molehat",
    function(inst) inst.components.fueled.fueltype = "CAVE" end)
AddPrefabPostInit("shop_buyer", function(inst)
    inst:ListenForEvent("daytime", function() inst.restock(inst, true) end,
        GetWorld())
end)

AddPrefabPostInit("city_lamp", function(inst) inst.Light:SetRadius(12) end)

AddPrefabPostInit("waterdrop", function(inst)
    if inst.components.inventoryitem ~= nil then
        inst:AddComponent("stackable")
        inst.components.stackable.maxsize = 9999
    end
end)
AddPrefabPostInit("tallbirdegg", function(inst)
    if inst.components.inventoryitem ~= nil then
        inst:AddComponent("stackable")
        inst.components.stackable.maxsize = 9999
    end
end)
AddPrefabPostInit("silvernecklace", function(inst)
    inst.components.equippable.equipslot = EQUIPSLOTS.NECK or EQUIPSLOTS.BODY
end)
AddPrefabPostInit("seeds_cooked", function(inst)
    inst.components.edible.hungervalue = 1
end)

local lowHungerValue = {"seeds", "seeds_cooked", "honey", "berries", "berries_cooked"}
for _, prefabName in ipairs(lowHungerValue) do
    AddPrefabPostInit(prefabName, function(inst) 
        inst.components.edible.hungervalue = 1 
    end)
end

AddPrefabPostInit("lantern", function(inst)
    local function fuelupdate(inst)
        local fuelpercent = inst.components.fueled:GetPercent()
        inst.Light:SetIntensity(Lerp(0.4, 0.6, fuelpercent))
        inst.Light:SetRadius(Lerp(5, 8, fuelpercent))
        inst.Light:SetFalloff(.9)
    end

    inst.Light:SetRadius(8)
    inst.components.fueled:SetUpdateFn(fuelupdate)
end)

AddPrefabPostInit("yellowamulet", function(inst)
    inst.Light:SetRadius(10)
    inst.Light:SetFalloff(0.7)
    inst.Light:SetIntensity(.65)
end)

AddPrefabPostInit("orangeamulet", function(inst)
    local function SpawnEffect(inst)
        local pt = inst:GetPosition()
        local fx = SpawnPrefab("small_puff")
        fx.Transform:SetPosition(pt.x, pt.y, pt.z)
        fx.Transform:SetScale(0.5, 0.5, 0.5)
    end

    local function getitem(player, amulet, item)
        -- Amulet will only ever pick up items one at a time. Even from stacks. NOOOOO MORE! =)
        SpawnEffect(item)
        amulet.components.finiteuses:Use(1)

        if item.components.stackable then
            local stackAmount = item.components.stackable:StackSize()
            item = item.components.stackable:Get(stackAmount)
        end

        if item.components.trap and item.components.trap:IsSprung() then
            item.components.trap:Harvest(player)
            return
        end

        player.components.inventory:GiveItem(item, nil, Vector3(
            TheSim:GetScreenPos(item.Transform:GetWorldPosition())))
    end

    local function pickup(inst, owner)
        local pt = owner:GetPosition()
        local ents = TheSim:FindEntities(pt.x, pt.y, pt.z,
            TUNING.ORANGEAMULET_RANGE, nil, {"INLIMBO", "NOFORAGE"})

        for k, v in pairs(ents) do
            if v.components.inventoryitem and
                v.components.inventoryitem.canbepickedup and
                v.components.inventoryitem.cangoincontainer and
                not v.components.inventoryitem:IsHeld() and
                not v:HasTag("projectile") and not v:HasTag("doydoy") and
                not v:HasTag("trap") and not v:HasTag("noautopickup") then

                if not owner.components.inventory:IsFull() then
                    -- Your inventory isn't full, you can pick something up.
                    getitem(owner, inst, v)
                    return

                elseif v.components.stackable then
                    -- Your inventory is full, but the item you're trying to pick up stacks. Check for an exsisting stack.
                    -- An acceptable stack should: Be of the same item type, not be full already and not be in the "active item" slot of inventory.
                    local stack = owner.components.inventory:FindItem(function(
                        item)
                        return (item.prefab == v.prefab and
                                   not item.components.stackable:IsFull() and
                                   item ~= owner.components.inventory.activeitem)
                    end)
                    if stack then
                        getitem(owner, inst, v)
                        return
                    end
                end
            end
        end
    end

    local function onequip_orange(inst, owner)
        -- owner.AnimState:OverrideSymbol("swap_body", "torso_amulets","orangeamulet")
        inst.task = inst:DoPeriodicTask(TUNING.ORANGEAMULET_ICD,
            function() pickup(inst, owner) end)
    end

    local function onunequip_orange(inst, owner) 
        -- owner.AnimState:ClearOverrideSymbol("swap_body")
        if inst.task then inst.task:Cancel() inst.task = nil end
    end

    inst.components.equippable:SetOnEquip(onequip_orange)    
    inst.components.equippable:SetOnUnequip(onunequip_orange)
    -- inst:RemoveComponent("finiteuses") 
end)

AddPrefabPostInit("bundle", function(inst)
    local function getName(inst)
        local description = ""

        if inst.components.unwrappable.itemdata then
            for i, v in ipairs(inst.components.unwrappable.itemdata) do
                local stringName = ''
                if i > 1 then
                    description = description .. ' | '
                end

                local stringName = STRINGS.NAMES[string.upper(v.prefab)]

                if stringName == '' then
                    description = description .. v.prefab
                else
                    description = description .. stringName
                end

                if v.data.stackable and v.data.stackable.stack ~= nil and v.data.stackable.stack > 0 then
                    description = description .. ' (' .. v.data.stackable.stack .. ')'
                end

            end
            return description
        else
            return "No Items"
        end
    end
    inst.components.inspectable:SetDescription(getName)
    inst.displaynamefn = getName
end)

AddPrefabPostInit("volcano_altar", function(inst)
    local function OnHammered(inst, worker)
        inst.SoundEmitter:PlaySound("dontstarve/common/destroy_metal")
        inst.meterprefab:Remove()
        inst.towerprefab:Remove()
        inst:Remove()
    end

    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(4)
    inst.components.workable:SetOnFinishCallback(OnHammered)
end)

AddPrefabPostInit("tunacan", function(inst)
    if inst.components.inventoryitem ~= nil then
        inst:AddComponent("stackable")
        inst.components.stackable.maxsize = 9999
    end

    inst.components.useableitem:SetOnUseFn(function(inst)
        inst.SoundEmitter:PlaySound("dontstarve_DLC002/common/can_open")
        local steak = SpawnPrefab("fish_med_cooked")
        GetPlayer().components.inventory:GiveItem(steak)

        if inst.components.stackable and inst.components.stackable.stacksize > 1 then
            inst.components.stackable:Get(1):Remove()
        else
            inst:Remove()
        end
    end)
end)

AddSimPostInit(customSimPostInit)

custom_tuning()
AddGamePostInit(custom_tuning)
AddSimPostInit(custom_tuning)

AddComponentPostInit("shopinterior", shopinteriorOverwrite)
AddComponentPostInit("economy", economyOverwrite)

local mergedGameTypes = {RECIPE_GAME_TYPE.VANILLA, RECIPE_GAME_TYPE.SHIPWRECKED,
                         RECIPE_GAME_TYPE.ROG, RECIPE_GAME_TYPE.PORKLAND}
local cityRecipeGameTypes = RECIPE_GAME_TYPE.COMMON

local function AddModRecipe(_recName, _ingrList, _tab, _techLevel, _recType,
    _placer, _spacing, _proxyLock, _amount)
    if GLOBAL.CAPY_DLC and GLOBAL.IsDLCEnabled(GLOBAL.CAPY_DLC) or
        GLOBAL.IsDLCEnabled(GLOBAL.PORKLAND_DLC) then
        return GLOBAL.Recipe(_recName, _ingrList, _tab, _techLevel, _recType,
            _placer, _spacing, _proxyLock, _amount)
    else
        return GLOBAL.Recipe(_recName, _ingrList, _tab, _techLevel, _placer,
            _spacing, _proxyLock, _amount)
    end
end

-- local blowpipemulti = AddModRecipe("blowpipemulti", {Ingredient("twigs", 10)}, RECIPETABS.WAR, TECH.NONE)
-- blowpipemulti.product = "blowdart_pipe"
-- blowpipemulti.image = "blowdart_pipe.tex"
-- blowpipemulti.numtogive = 10
-- STRINGS.NAMES.BLOWPIPEMULTI = "Blow Darts x 10"
-- STRINGS.RECIPE_DESC.BLOWPIPEMULTI = "Spit more teeth at your enemies."

local staff_tornado_pay = AddModRecipe("staff_tornado_pay",
    {Ingredient("goldnugget", 5)}, RECIPETABS.WAR, TECH.NONE)
staff_tornado_pay.product = "staff_tornado"
staff_tornado_pay.image = "staff_tornado.tex"
staff_tornado_pay.numtogive = 1
STRINGS.NAMES.STAFF_TORNADO_PAY = "Weather Pain"
STRINGS.RECIPE_DESC.STAFF_TORNADO_PAY = "I Pay for your pain!"

local lightberry = AddModRecipe("lightberry", {Ingredient("lightbulb", 10)},
    RECIPETABS.LIGHT, TECH.SCIENCE_TWO)
lightberry.product = "wormlight"
lightberry.image = "wormlight.tex"
lightberry.numtogive = 3
STRINGS.NAMES.LIGHTBERRY = "Wormlight x 3"
STRINGS.RECIPE_DESC.LIGHTBERRY = "Now I see you"

-- local key_to_city = AddModRecipe("key_to_city", {Ingredient("goldnugget", 5)}, RECIPETABS.TOOLS,  TECH.SCIENCE_TWO, mergedGameTypes)
-- key_to_city.product = "key_to_city"
-- key_to_city.image = "key_to_city.tex"
-- key_to_city.numtogive = 1
-- STRINGS.NAMES.KEY_TO_CITY = "Key to the City"
-- STRINGS.RECIPE_DESC.KEY_TO_CITY = "Now I build my KINGDOM"

-- local city_hammer = AddModRecipe("city_hammer", {Ingredient("goldnugget", 5)}, RECIPETABS.TOOLS,  TECH.SCIENCE_TWO, mergedGameTypes)
-- city_hammer.product = "city_hammer"
-- city_hammer.image = "city_hammer.tex"
-- city_hammer.numtogive = 1
-- STRINGS.NAMES.CITY_HAMMER = "City Hammer"
-- STRINGS.RECIPE_DESC.CITY_HAMMER = "Now I destroy my KINGDOM"

-- local cityoinc = AddModRecipe("cityoinc", {Ingredient("goldnugget", 5)}, RECIPETABS.TOOLS,  TECH.SCIENCE_TWO, mergedGameTypes)
-- cityoinc.product = "oinc"
-- cityoinc.image = "oinc.tex"
-- cityoinc.numtogive = 20
-- STRINGS.NAMES.CITYOINC = "Oinc"
-- STRINGS.RECIPE_DESC.CITYOINC = "Oinc Oinc x20"

local babybeefalo = AddModRecipe("babybeefalo", {Ingredient("beefalowool", 5),
                                                 Ingredient("horn", 1)},
    RECIPETABS.FARM, TECH.NONE)
babybeefalo.image = "brush.tex"
STRINGS.NAMES.BABYBEEFALO = "Babybeefalo"
STRINGS.RECIPE_DESC.BABYBEEFALO = ""

-- local pog = AddModRecipe("pog", {Ingredient("smallmeat", 4),Ingredient("meat", 1),Ingredient("goldnugget", 1)}, RECIPETABS.FARM, TECH.NONE)
-- pog.image = "brush.tex"
-- STRINGS.NAMES.POG = "Pog"
-- STRINGS.RECIPE_DESC.POG = ""

-- local peagawk = AddModRecipe("peagawk",
--     {Ingredient("drumstick", 2), Ingredient("meat", 1),
--      Ingredient("doydoyfeather", 5)}, RECIPETABS.FARM, TECH.NONE)
-- peagawk.image = "brush.tex"
-- STRINGS.NAMES.PEAGAWK = "Peagawk"
-- STRINGS.RECIPE_DESC.PEAGAWK = ""

local doydoyfoodclipping = AddModRecipe("seeds_cooked",
    {Ingredient("berries", 5)}, RECIPETABS.FARM, TECH.NONE)
doydoyfoodclipping.image = "seeds_cooked.tex"
doydoyfoodclipping.numtogive = 25
STRINGS.NAMES.DOYDOYFOODCLIPPING = "Toasted Seeds"
STRINGS.RECIPE_DESC.DOYDOYFOODCLIPPING = "Toasted Seeds x25"

-- Recipe("beebox", {Ingredient("boards", 2),Ingredient("honeycomb", 1),Ingredient("bee", 4)}, RECIPETABS.FARM, TECH.SCIENCE_ONE, {RECIPE_GAME_TYPE.VANILLA,RECIPE_GAME_TYPE.ROG,RECIPE_GAME_TYPE.SHIPWRECKED}, "beebox_placer")

local beebox = AddModRecipe("beebox", {Ingredient("boards", 5),
                                       Ingredient("honeycomb", 1),
                                       Ingredient("stinger", 10)},
    RECIPETABS.FARM, TECH.SCIENCE_ONE, mergedGameTypes, "beebox_placer")
-- local living_artifact = AddModRecipe("living_artifact", {Ingredient("infused_iron", 6),Ingredient("waterdrop", 1)}, RECIPETABS.MAGIC, TECH.MAGIC_THREE, mergedGameTypes)
local pig_shop_antiquities = AddModRecipe("pig_shop_antiquities", {Ingredient(
    "boards", 4), Ingredient("hammer", 3), Ingredient("pigskin", 4)},
    RECIPETABS.CITY, TECH.CITY, cityRecipeGameTypes,
    "pig_shop_antiquities_placer", nil, true)
-- Recipe("hedge_block_item", {Ingredient("clippings", 9), Ingredient("nitre", 1)}, RECIPETABS.CITY, TECH.CITY, cityRecipeGameTypes, nil, nil, true, 3)
local hedge_block_item = AddModRecipe("hedge_block_item", {Ingredient("boards",
    1), Ingredient("nitre", 1)}, RECIPETABS.CITY, TECH.CITY,
    cityRecipeGameTypes, nil, nil, true, 3)
local pig_shop_tinker = AddModRecipe("pig_shop_tinker",
    {Ingredient("cutstone", 4), Ingredient("pitchfork", 3),
     Ingredient("pigskin", 4)}, RECIPETABS.CITY, TECH.CITY, cityRecipeGameTypes,
    "pig_shop_tinker_placer", nil, true)
local playerhouse_city = AddModRecipe("playerhouse_city", {Ingredient("boards",
    5), Ingredient("cutstone", 5)}, RECIPETABS.CITY, TECH.NONE, mergedGameTypes,
    "playerhouse_city_placer", nil, true)
-- Recipe("construction_permit", {Ingredient("oinc", 50)}, RECIPETABS.HOME, TECH.HOME_TWO, cityRecipeGameTypes, nil, nil, true)
local construction_permit = AddModRecipe("construction_permit",
    {Ingredient("oinc", 10)}, RECIPETABS.HOME, TECH.HOME_TWO,
    cityRecipeGameTypes, nil, nil, true)
local city_lamp = AddModRecipe("city_lamp",
    {Ingredient("cutstone", 2), Ingredient("transistor", 1),
     Ingredient("lightbulb", 5)}, RECIPETABS.CITY, TECH.NONE,
    cityRecipeGameTypes, "city_lamp_placer", nil, true)
local turf_foundation = AddModRecipe("turf_foundation",
    {Ingredient("cutstone", 1)}, RECIPETABS.CITY, TECH.CITY,
    cityRecipeGameTypes, nil, nil, true)
turf_foundation.numtogive = 30
local turf_cobbleroad = AddModRecipe("turf_cobbleroad", {Ingredient("cutstone",
    1), Ingredient("boards", 1)}, RECIPETABS.CITY, TECH.CITY,
    cityRecipeGameTypes, nil, nil, true)
turf_cobbleroad.numtogive = 30
local earringOinc = AddModRecipe("oinc", {Ingredient("earring", 5)}, RECIPETABS.TOOLS, TECH.NONE,
    cityRecipeGameTypes, nil, nil, true)
earringOinc.numtogive = 100
-- local thulecite = AddModRecipe("thulecite", {Ingredient("rocks", 1), Ingredient("goldnugget", 2)}, RECIPETABS.ANCIENT, TECH.ANCIENT_FOUR, mergedGameTypes, nil, nil, true)

local volcano_altar = AddModRecipe("volcano_altar",
    {Ingredient("cutstone", 10)}, RECIPETABS.TOWN, TECH.SCIENCE_ONE,
    RECIPE_GAME_TYPE.SHIPWRECKED, "dragoonden_placer")
volcano_altar.image = "skull_wallace.tex"
STRINGS.NAMES.VOLCANO_ALTAR = "Volcano Altar of Snackrifice"
STRINGS.RECIPE_DESC.VOLCANO_ALTAR = "Delays or speeds up eruptions."

