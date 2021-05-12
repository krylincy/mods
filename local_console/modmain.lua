STRINGS = GLOBAL.STRINGS
RECIPETABS = GLOBAL.RECIPETABS
Recipe = GLOBAL.Recipe
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


local function custom_console( inst )

	GLOBAL.RunScript("consolecommands")
	
	--inst:DoTaskInTime( 0.001, function()
		
		--GetPlayer().components.locomotor.runspeed = 9
		--GetPlayer().components.health:SetMaxHealth(400)
		
	--end)
end

function custom_tuning()
	local total_day_time = 30*16

    TUNING["STACK_SIZE_LARGEITEM"] = 10000
    TUNING["STACK_SIZE_MEDITEM"] = 10000
    TUNING["STACK_SIZE_SMALLITEM"] = 10000
	--TUNING.WILSON_WALK_SPEED = 5
	--TUNING.WILSON_RUN_SPEED = 9
	
	--WILSON_HUNGER_RATE = calories_per_day/total_day_time, --calories burnt per day
	TUNING.WILSON_HUNGER_RATE = 200/480 -- default: 75/480
	
	TUNING.PIPE_DART_DAMAGE = 500
	TUNING.TORNADOSTAFF_USES = 500
	--TUNING.TORNADO_DAMAGE = 100
	
	TUNING.ABIGAIL_SPEED = 9
	TUNING.ABIGAIL_DAMAGE_PER_SECOND = 80
	
	--TUNING.FLIPPABLE_ROCK_REPOPULATE_TIME = total_day_time*1
	--TUNING.FLIPPABLE_ROCK_REPOPULATE_INCREASE = 0
	--TUNING.FLIPPABLE_ROCK_REPOPULATE_VARIANCE = 0
	--TUNING.FLIPPABLE_ROCK_CYCLES = 999
	
	TUNING.ORANGEAMULET_USES = 2000
	TUNING.ORANGEAMULET_RANGE = 20
	TUNING.ORANGEAMULET_ICD = 0.15
	
	TUNING.BERRYBUSH_CYCLES = 100
		
	
	-- local world = GetWorld()
	-- if world.components.cityalarms then
		-- world:RemoveComponent("cityalarms") 		
	-- end
end

function shopinteriorOverwrite(self,inst)
	local SHOPTYPES = 
	{
		["DEFAULT"] = {"rocks", "flint", "goldnugget"},

		["pig_shop_deli"] = {
								--{ "tea",     "oinc", 1  },
								{ "coffee",     "oinc", 1  },
								--{ "spicyvegstinger",     "oinc", 2  },
								--{ "feijoada",    "oinc", 3  },
								--{ "snakebonesoup",    "oinc", 3  },
								{ "lobsterdinner",       "oinc", 3 },
								--{ "nettlelosange",       "oinc", 3 },
								--{ "bonestew",       "oinc", 5 },
								{ "freshfruitcrepes",       "oinc", 4 },
							},
		
		["pig_shop_florist"] = {								
								--{ "seeds",        "oinc", 1  },
								--{ "pumpkin_seeds",        "oinc", 2  },
								--{ "asparagus_seeds",             "oinc", 2  },
								--{ "dragonfruit_seeds",             "oinc", 10  },
								--{ "eggplant_seeds",             "oinc", 2  },
								--{ "acorn",             "oinc", 2  },
								{ "pinecone",          "oinc", 2  },
								{ "burr",    "oinc", 2  },
								{ "teatree_nut",    "oinc", 2  },
								{ "jungletreeseed",    "oinc", 2  },
								--{ "dug_sapling",     "oinc", 2  },
								--{ "dug_berrybush",     "oinc", 5  },
								{ "dug_berrybush2",     "oinc", 5  },
								--{ "dug_bush_vine",     "oinc", 3  },
								--{ "dug_bambootree",     "oinc", 3  },
							},

		["pig_shop_general"] = {										
								--{ "minerhat",   "oinc", 20 },
								{ "bandage",      "oinc", 3  },
								--{ "bandage",      "oinc", 3  },
								{ "antivenom",    "oinc", 5 },
								--{ "bugnet",      "oinc", 10  },
								--{ "shears",      "oinc", 10  },
								--{ "sewing_kit",      "oinc", 5  },
								--{ "bugrepellent",   "oinc", 10 },                     
								--{ "walkingstick",   "oinc", 10 },                     
								--{ "magnifying_glass",   "oinc", 10 },                     
								--{ "ballpein_hammer",   "oinc", 10 },                     
								{ "multitool_axe_pickaxe", "oinc", 50 },                            
								--{ "yellowstaff", "oinc", 40 },                            
								--{ "gasmaskhat", "oinc", 40 }, 
								{ "orangeamulet", "oinc", 30 },       
								--{ "yellowamulet", "oinc", 30 },       
								{ "greenamulet", "oinc", 30 },       
								--{ "boards", "oinc", 1 },       
								{ "cutstone", "oinc", 1 },       
							},
		["pig_shop_general_fiesta"] = {                            
								{ "firecrackers",  "oinc", 1  },
								{ "firecrackers",  "oinc", 1  },
								{ "firecrackers",  "oinc", 1  },
								{ "firecrackers",  "oinc", 1  },
								{ "magnifying_glass",  "oinc", 10  },
								{ "ballpein_hammer",     "oinc", 10  },
								{ "minerhat",   "oinc", 20 },
								{ "ox_flute",   "oinc", 20 },
								{ "bugnet",      "oinc", 10  },
								{ "shears",      "oinc", 10  },
								{ "bugrepellent",   "oinc", 10 },
								{ "multitool_axe_pickaxe", "oinc", 50 },                            
								{ "gasmaskhat", "oinc", 40 },                                                                                       
							},
		["pig_shop_hoofspa"] = {
								
								--{ "thulecite",      "oinc", 5 },
								{ "thulecite",      "oinc", 5 },
								--{ "infused_iron",      "oinc", 20 },
								--{ "alloy",              "oinc", 3  },                            
								{ "iron",              "oinc", 1  },                            
								--{ "rocks",  "oinc", 0 }, 
								--{ "rocks",  "oinc", 0 }, 
								{ "rocks",  "oinc", 1 }, 
								{ "nitre",  "oinc", 1 }, 
								{ "houndstooth",       "oinc", 2  },							
								--{ "lightbulb",  "oinc", 2 },
								--{ "living_artifact",  "oinc", 100 }, 
								{ "boneshard",			"oinc", 2  },
							},

		["pig_shop_produce"] = {
								--{ "rainbowjellyfish_dead",    "oinc", 5 },					
								{ "cave_banana",  "oinc", 1 },
								{ "mandrake",      "oinc", 20 },
								{ "coconut",      "oinc", 1 },
								{ "venus_stalk",      "oinc", 5 },
								{ "clippings",     "oinc", 1  },
								{ "clippings",     "oinc", 1  },
								--{ "bird_egg",     "oinc", 1  },
								--{ "butter",     "oinc", 5  },    
								--{ "butterflywings",     "oinc", 2  },
								--{ "tuber_bloom_crop",     "oinc", 3  },
								--{ "bramble_bulb",     "oinc", 5  },
								{ "waterdrop",      "oinc", 100 },	
								{ "honeycomb",             "oinc", 5 },								
								--{ "blubber",             "oinc", 3 },								
								--{ "bundlewrap",             "oinc", 10 },	
								{ "wormlight",         "oinc", 10 },							
							},

		["pig_shop_antiquities"] = {                     
								--{ "gears",             "oinc", 10 },								
								--{ "bamboo",            "oinc", 3  },                            
								{ "cutreeds",            "oinc", 2  },                          
								{ "fabric",     "oinc", 2  },
								{ "livinglog",    "oinc", 10  },
								{ "lightbulb",  "oinc", 2 },  
								{ "pigskin",     "oinc", 2  },
								{ "pigskin",     "oinc", 2  },
								{ "beefalowool",     "oinc", 1  },
								
							},

		["pig_shop_cityhall"] = {                       
							},

		["pig_shop_arcane"] = {	
								{ "kingfisher",  "oinc", 10 }, 
								--{ "toucan",  "oinc", 20 }, 
								--{ "parrot_blue",  "oinc", 20 }, 
								{ "parrot",  "oinc", 20 }, 
								--{ "peagawk",  "oinc", 20 },  
								--{ "mole",  "oinc", 10 },  
								{ "rabbit",  "oinc", 5 },   
								--{ "rabbit",  "oinc", 5 }, 
								--{ "crab",  "oinc", 10 }, 
								{ "piko",  "oinc", 5 }, 
								{ "piko_orange",  "oinc", 5 }, 
								{ "spidereggsack",  "oinc", 20 }, 
								{ "doydoybaby",  "oinc", 50 }, 
								{ "butterfly",  "oinc", 1 },
								{ "butterfly",  "oinc", 1 },
								{ "butterfly",  "oinc", 1 },
								{ "butterfly",  "oinc", 1 },
								{ "fireflies",       "oinc", 5  },	
							},  
		["pig_shop_weapons"] = {
								--{ "footballhat",          "oinc", 5  },
								{ "halberd",          "oinc", 5  },
								--{ "armor_metalplate",        "oinc", 20  },
								--{ "antsuit",        "oinc", 30  },
								--{ "antmaskhat",        "oinc", 30  },
								--{ "armordragonfly",        "oinc", 50 },
								--{ "armor_weevole",     "oinc", 10 },
								{ "ruinshat",        "oinc", 20 },
								{ "armorruins",        "oinc", 20 },
								{ "eyeturret_item", "oinc", 200 },
								{ "cutlass", "oinc", 10 },
								{ "ruins_bat", "oinc", 10 },
							},                      
		["pig_shop_hatshop"] = {                        
								--{ "tophat",      "oinc", 10 },
								{ "molehat",     "oinc", 20 },
								--{ "featherhat",  "oinc", 5  },
								{ "brainjellyhat",    "oinc", 100  },
								{ "blubbersuit",     "oinc", 20 },
								{ "beargervest",     "oinc", 20 },
								{ "hawaiianshirt",     "oinc", 20 },
								{ "pithhat",     "oinc", 10 },
								--{ "beehat",     "oinc", 10 },
								--{ "gashat",     "oinc", 20 },
								--{ "bathat",     "oinc", 20 },
								{ "gasmaskhat",     "oinc", 20 },
								--{ "reflectivevest",     "oinc", 20 },
								{ "armor_windbreaker",     "oinc", 20 },
								--{ "eyebrellahat",     "oinc", 30 },
								{ "double_umbrellahat",     "oinc", 40 },
							},  
		["pig_shop_bank"] = {                        
								{ "goldnugget",  "oinc", 20 },
								{ "oinc10",      "oinc", 10 },
								{ "oinc100",     "oinc", 100  },
							},
		["pig_shop_tinker"] = {                        
								
								--{ "turf_savanna", "oinc", 1 },  
								--{ "turf_desertdirt", "oinc", 1 },  
								{ "turf_meadow", "oinc", 1 },	
								{ "turf_fields", "oinc", 1 },  
								{ "turf_lawn", "oinc", 1 },  
								--{ "turf_foundation", "oinc", 1 },  
								
								--{ "turf_cobbleroad", "oinc", 1 },  
								--{ "turf_road", "oinc", 2 },   
							},                                                  
		["pig_shop_academy"] = {
							},
	}
	
	function self:GetNewProduct(shoptype)
		if GLOBAL.GetAporkalypse() and GLOBAL.GetAporkalypse():GetFiestaActive() and SHOPTYPES[shoptype.."_fiesta"] then
			shoptype = shoptype.."_fiesta"
		end
		local items = SHOPTYPES[shoptype]
		if items then
			local itemset = GLOBAL.GetRandomItem(items)
			return itemset
		end
	end
	
	function self:MakeShop(numItems, shopType)
		local x,y,z = self.inst.Transform:GetWorldPosition()
		self.shopType = shopType
		if SHOPTYPES[shopType] then 
			self.items = SHOPTYPES[shopType]
			self:FillPedestals(numItems, shopType)
		end 
	end 
end

function economyOverwrite(self,inst)
	local TRADER = {
		pigman_collector = 		{ items= {"hippo_antler","bill_quill","tallbirdegg", "doydoyegg","horn", "dragoonheart", "lureplantbulb", "tigereye","spidereggsack", "shark_fin", "turbine_blades", "snakeoil", "shark_gills", "magic_seal"},					
									delay=0, reset=0, current=0, desc=STRINGS.CITY_PIG_COLLECTOR_TRADE,  reward = "oinc",   rewardqty=10},
		pigman_banker = 		{ items= {"redgem","bluegem","greengem", "orangegem", "yellowgem"},
									delay=0, reset=0, current=0, desc=STRINGS.CITY_PIG_BANKER_TRADE, 	 reward = "oinc", rewardqty=10},
		pigman_beautician = 	{ items= {"feather_crow","feather_robin","feather_robin_winter","peagawkfeather", "feather_thunder", "doydoyfeather"},					
									delay=0, reset=0, current=0, desc=STRINGS.CITY_PIG_BEAUTICIAN_TRADE, reward = "oinc",   rewardqty=2},
		pigman_mechanic = 		{ items= {"boards","rope","cutstone","papyrus"},
									delay=0, reset=1, current=0, desc=STRINGS.CITY_PIG_MECHANIC_TRADE, 	 reward = "oinc",   rewardqty=2},
		pigman_professor =		{ items= {"relic_1", "relic_2", "relic_3","bandithat"}, 
									delay=0, reset=0, current=0, desc=STRINGS.CITY_PIG_PROFESSOR_TRADE,  reward = "oinc", rewardqty=10},								
	 
		pigman_hunter = 		{ items= {"houndstooth","stinger"},	   delay=0, reset=0, current=0, desc=STRINGS.CITY_PIG_HUNTER_TRADE, 	reward = "oinc",   rewardqty=1},
		pigman_mayor = 			{ items= {"goldnugget"},	   delay=0, reset=0, current=0, desc=STRINGS.CITY_PIG_MAYOR_TRADE, 	    reward = "oinc",   rewardqty=5},
		pigman_florist = 		{ items= {"petals"},   		   delay=0, reset=0, current=0, desc=STRINGS.CITY_PIG_FLORIST_TRADE,    reward = "oinc",   rewardqty=1},
		pigman_storeowner = 	{ items= {"clippings","waxpaper"},		   delay=0, reset=0, current=0, desc=STRINGS.CITY_PIG_STOREOWNER_TRADE, reward = "oinc",   rewardqty=1},
		pigman_farmer = 		{ items= {"cutgrass","twigs"}, delay=0, reset=1, current=0, desc=STRINGS.CITY_PIG_FARMER_TRADE, 	reward = "oinc",   rewardqty=1},
		pigman_miner = 			{ items= {"rocks"},			   delay=0, reset=1, current=0, desc=STRINGS.CITY_PIG_MINER_TRADE, 	    reward = "oinc",   rewardqty=1},
		pigman_erudite = 		{ items= {"nightmarefuel"},	   delay=0, reset=0, current=0, desc=STRINGS.CITY_PIG_ERUDITE_TRADE,    reward = "oinc",   rewardqty=5},
		pigman_hatmaker =		{ items= {"silk"},			   delay=0, reset=1, current=0, desc=STRINGS.CITY_PIG_HATMAKER_TRADE,	reward = "oinc",   rewardqty=5},
		pigman_queen = 			{ items= {"pigcrownhat","pig_scepter","relic_4","relic_5"},
								   delay=0, reset=0, current=0, desc=STRINGS.CITY_PIG_QUEEN_TRADE,		reward = "pedestal_key",   rewardqty=1},
		pigman_usher =		    { items= {"honey","jammypreserves","icecream","pumpkincookie","waffles","berries","berries_cooked"},                 
									delay=0, reset=0, current=0, desc=STRINGS.CITY_PIG_USHER_TRADE,  reward = "oinc",   rewardqty=2},

	--	pigman_royalguard = 	{items={"spear","spear_wathgrithr"},
	--															num=3, current=0,	desc=STRINGS.CITY_PIG_GUARD_TRADE, 		reward = "oinc"},
	--	pigman_royalguard_2 = 	{items={"spear","spear_wathgrithr"},				
	--															num=3, current=0,	desc=STRINGS.CITY_PIG_GUARD_TRADE, 		reward = "oinc"},	
	--	pigman_shopkeep = 		{items={},						num=5, current=0,	desc=STRINGS.CITY_PIG_SHOPKEEP_TRADE, 	reward = "oinc"},
	}


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


	function self:AddCity(city)  
		self.cities[city] = GLOBAL.deepcopy(TRADER)

		for i,item in pairs(self.cities[city]) do
			item.GUIDS = {}
		end
	end
	
	for i=1,GLOBAL.NUM_TRINKETS do
		table.insert(TRADER.pigman_collector.items, "trinket_" .. i)
	end
end

AddPrefabPostInit("gashat", function(inst) inst:AddTag("gasmask") end)
AddPrefabPostInit("honeycomb", function(inst) inst:AddTag("fireimmune") end)
AddPrefabPostInit("grass", function(inst) 
	local function ontransplantfn(inst)
		if inst.components.pickable then
			inst.components.pickable:MakeEmpty()
		end
	end

	inst:AddTag("fireimmune") 
	inst.components.pickable.ontransplantfn = ontransplantfn
	inst.components.pickable.max_cycles = 100
	inst.components.pickable.cycles_left = 100
end)
AddPrefabPostInit("sapling", function(inst) inst:AddTag("fireimmune") end)
AddPrefabPostInit("berrybush", function(inst) 
	local function ontransplantfn(inst)
		if inst.components.pickable then
			inst.components.pickable:MakeEmpty()
		end
	end

	inst:AddTag("fireimmune") 
	inst.components.pickable.ontransplantfn = ontransplantfn
end)

AddPrefabPostInit("berrybush2", function(inst) 
	local function ontransplantfn(inst)
		if inst.components.pickable then
			inst.components.pickable:MakeEmpty()
		end
	end

	inst:AddTag("fireimmune") 
	inst.components.pickable.ontransplantfn = ontransplantfn
end)

AddPrefabPostInit("bush_vine", function(inst) inst:AddTag("fireimmune") end)
AddPrefabPostInit("bambootree", function(inst) inst:AddTag("fireimmune") end)
AddPrefabPostInit("reeds", function(inst) inst:AddTag("fireimmune") end)
AddPrefabPostInit("reeds_water", function(inst) inst:AddTag("fireimmune") end)
AddPrefabPostInit("beebox", function(inst) inst:AddTag("fireimmune") end)
AddPrefabPostInit("cookpot", function(inst) inst:AddTag("fireimmune") end)
AddPrefabPostInit("slow_farmplot", function(inst) inst:AddTag("fireimmune") end)
AddPrefabPostInit("fast_farmplot", function(inst) inst:AddTag("fireimmune") end)
AddPrefabPostInit("grass_tall", function(inst) inst:AddTag("fireimmune") end)
AddPrefabPostInit("flower_cave", function(inst) inst:AddTag("fireimmune") end)
AddPrefabPostInit("flower_cave_double", function(inst) inst:AddTag("fireimmune") end)
AddPrefabPostInit("flower_cave_triple", function(inst) inst:AddTag("fireimmune") end)
AddPrefabPostInit("nettle", function(inst) inst:AddTag("fireimmune") end)
AddPrefabPostInit("fence", function(inst) inst:AddTag("fireimmune") end)
AddPrefabPostInit("fence_gate", function(inst) inst:AddTag("fireimmune") end)
AddPrefabPostInit("wall_wood", function(inst) inst:AddTag("fireimmune") end)
AddPrefabPostInit("plant_normal", function(inst) inst:AddTag("fireimmune") end)

AddPrefabPostInit("flower", function(inst) inst:RemoveComponent("blowinwindgust") end)
AddPrefabPostInit("flower_evil", function(inst) inst:RemoveComponent("blowinwindgust") end)

AddPrefabPostInit("tentaclespike", function(inst) 
    inst:AddTag("burnable")
end)

-- AddPrefabPostInit("tentacle", function(inst) 
-- GLOBAL.SetSharedLootTable( 'tentacle',
-- {
    -- {'monstermeat',   1.0},
    -- {'monstermeat',   1.0},
    -- {'tentaclespots', 0.5},
-- })

	 -- inst.components.lootdropper:SetChanceLootTable('tentacle')
-- end)

AddPrefabPostInit("multitool_axe_pickaxe", function(inst) 
	--inst:RemoveComponent("finiteuses") 
	inst.components.tool:SetAction(ACTIONS.DISLODGE, 10)
	inst.components.tool:SetAction(ACTIONS.DISARM, 10)
	inst.components.tool:SetAction(ACTIONS.CHOP, 10)
	inst.components.tool:SetAction(ACTIONS.MINE, 10)
	inst.components.tool:SetAction(ACTIONS.HACK, 10)
	inst.components.tool:SetAction(ACTIONS.SHEAR, 10)
	--inst.components.tool:SetAction(ACTIONS.DIG, 10)
	--inst.components.tool:SetAction(ACTIONS.HAMMER)
	inst:AddComponent("dislodger")
	inst:AddComponent("disarming")
end)
AddPrefabPostInit("lightbulb", function(inst) 
	inst:RemoveComponent("edible") 
	inst:RemoveComponent("perishable")
end)
AddPrefabPostInit("healingsalve", function(inst) 
	inst.components.healer:SetHealthAmount(60)
end)
AddPrefabPostInit("bandage", function(inst) 
	inst.components.healer:SetHealthAmount(60)
end)
AddPrefabPostInit("wormlight", function(inst) 
	inst.components.fuel.fueltype = "CAVE"
end)
AddPrefabPostInit("molehat", function(inst) 
	inst.components.fueled.fueltype = "CAVE"
end)
AddPrefabPostInit("shop_buyer", function(inst) 
	inst:ListenForEvent("daytime", function() inst.restock(inst,true) end, GetWorld())
end)

AddPrefabPostInit("city_lamp", function(inst) 
    inst.Light:SetRadius( 12 )
end)

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
AddPrefabPostInit("tunacan", function(inst) 
    if inst.components.inventoryitem ~= nil then
		inst:AddComponent("stackable")
		inst.components.stackable.maxsize = 9999
	end
end)
AddPrefabPostInit("silvernecklace", function(inst) 
    inst.components.equippable.equipslot = EQUIPSLOTS.NECK or EQUIPSLOTS.BODY
end)
AddPrefabPostInit("clippings", function(inst) 
    inst:AddTag("noautopickup")
	GLOBAL.MakeBlowInHurricane(inst, 0.00001, 0.00002) -- HEAVY
end)
AddPrefabPostInit("berries", function(inst) 
    inst:AddTag("noautopickup")
	GLOBAL.MakeBlowInHurricane(inst, 0.00001, 0.00002) -- HEAVY
end)
AddPrefabPostInit("seeds_cooked", function(inst)
    inst:AddTag("noautopickup")
	GLOBAL.MakeBlowInHurricane(inst, 0.00001, 0.00002) -- HEAVY
end)
AddPrefabPostInit("corn", function(inst)
    inst:AddTag("noautopickup")
	GLOBAL.MakeBlowInHurricane(inst, 0.00001, 0.00002) -- HEAVY
end)
AddPrefabPostInit("corn_cooked", function(inst)
    inst:AddTag("noautopickup")
	GLOBAL.MakeBlowInHurricane(inst, 0.00001, 0.00002) -- HEAVY
end)
AddPrefabPostInit("seatrap", function(inst) inst:AddTag("noautopickup") end)

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
		fx.Transform:SetScale(0.5,0.5,0.5)
	end

	local function getitem(player, amulet, item)
		--Amulet will only ever pick up items one at a time. Even from stacks. NOOOOO MORE! =)
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
		
		player.components.inventory:GiveItem(item, nil, Vector3(TheSim:GetScreenPos(item.Transform:GetWorldPosition())))
	end

	local function pickup(inst, owner)
		local pt = owner:GetPosition()
		local ents = TheSim:FindEntities(pt.x, pt.y, pt.z, TUNING.ORANGEAMULET_RANGE,nil,{"INLIMBO", "NOFORAGE"})

		for k,v in pairs(ents) do
			if v.components.inventoryitem and v.components.inventoryitem.canbepickedup and v.components.inventoryitem.cangoincontainer and not
				v.components.inventoryitem:IsHeld() and not v:HasTag("projectile") and not v:HasTag("doydoy") and not v:HasTag("trap") and not v:HasTag("noautopickup") then

				if not owner.components.inventory:IsFull() then
					--Your inventory isn't full, you can pick something up.
					getitem(owner, inst, v)
					return

				elseif v.components.stackable then
					--Your inventory is full, but the item you're trying to pick up stacks. Check for an exsisting stack.
					--An acceptable stack should: Be of the same item type, not be full already and not be in the "active item" slot of inventory.
					local stack = owner.components.inventory:FindItem(function(item) return (item.prefab == v.prefab and not item.components.stackable:IsFull()
						and item ~= owner.components.inventory.activeitem) end)
					if stack then
						getitem(owner, inst, v)
						return
					end
				end
			end
		end		
	end

    local function onequip_orange(inst, owner) 
		owner.AnimState:OverrideSymbol("swap_body", "torso_amulets", "orangeamulet")
		inst.task = inst:DoPeriodicTask(TUNING.ORANGEAMULET_ICD, function() pickup(inst, owner) end)
	end
	
	inst.components.equippable:SetOnEquip( onequip_orange )
	--inst:RemoveComponent("finiteuses") 
end)

AddPrefabPostInit("bundle", function(inst) 
	local function getName(inst)
		local description =""	
		
		if inst.components.unwrappable.itemdata then
			for i, v in ipairs(inst.components.unwrappable.itemdata) do
				local stringName = ''
				if i > 1 then
					description = description..' | '
				end

				local stringName = STRINGS.NAMES[string.upper(v.prefab)]

				if stringName == '' then
					description = description..v.prefab
				else
					description = description..stringName
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


--AddSimPostInit(custom_console)

custom_tuning()
AddGamePostInit(custom_tuning)
AddSimPostInit(custom_tuning)
AddComponentPostInit("shopinterior",shopinteriorOverwrite)
AddComponentPostInit("economy",economyOverwrite)

