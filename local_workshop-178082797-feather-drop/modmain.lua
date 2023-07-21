-- Birdcage mod version 2.0
-- by _Q_
if GetModConfigData("Feather Drop Time") == "rarer" then
	TUNING.FEATHER_DROP_TIME = 10 * TUNING.TOTAL_DAY_TIME
end

if GetModConfigData("Feather Drop Time") == "rare" then
	TUNING.FEATHER_DROP_TIME = TUNING.TOTAL_DAY_TIME
end

if GetModConfigData("Feather Drop Time") == "less" then
	TUNING.FEATHER_DROP_TIME = 0.7 * TUNING.TOTAL_DAY_TIME
end

if GetModConfigData("Feather Drop Time") == "default" then
	TUNING.FEATHER_DROP_TIME = 0.5 * TUNING.TOTAL_DAY_TIME
end

if GetModConfigData("Feather Drop Time") == "more" then
	TUNING.FEATHER_DROP_TIME = 0.3 * TUNING.TOTAL_DAY_TIME
end

if GetModConfigData("Feather Drop Time") == "often" then
	TUNING.FEATHER_DROP_TIME = 0.2 * TUNING.TOTAL_DAY_TIME
end

if GetModConfigData("Feathers On Ground Limit") == "rare" then
	TUNING.FEATHERS_ON_GROUND = 2
end

if GetModConfigData("Feathers On Ground Limit") == "less" then
	TUNING.FEATHERS_ON_GROUND = 4
end

if GetModConfigData("Feathers On Ground Limit") == "default" then
	TUNING.FEATHERS_ON_GROUND = 6
end

if GetModConfigData("Feathers On Ground Limit") == "more" then
	TUNING.FEATHERS_ON_GROUND = 8
end

if GetModConfigData("Feathers On Ground Limit") == "often" then
	TUNING.FEATHERS_ON_GROUND = 10
end

if GetModConfigData("Amount Of Named Seeds") == "one" then
	TUNING.SEEDS_AMOUNT_LOWER = 1
	TUNING.SEEDS_AMOUNT_UPPER = 1
end

if GetModConfigData("Amount Of Named Seeds") == "two" then
	TUNING.SEEDS_AMOUNT_LOWER = 1
	TUNING.SEEDS_AMOUNT_UPPER = 2
end

if GetModConfigData("Amount Of Named Seeds") == "three" then
	TUNING.SEEDS_AMOUNT_LOWER = 2
	TUNING.SEEDS_AMOUNT_UPPER = 3
end

if GetModConfigData("Amount Of Named Seeds") == "four" then
	TUNING.SEEDS_AMOUNT_LOWER = 2
	TUNING.SEEDS_AMOUNT_UPPER = 4
end

function birdcagePrefabPostInit(inst)
	inst:AddComponent("feathers")
end

AddPrefabPostInit("birdcage", birdcagePrefabPostInit)

function featherPrefabPostInit(inst)
	inst:AddTag("feather")
end

AddPrefabPostInit("feather_crow", featherPrefabPostInit)
AddPrefabPostInit("feather_robin", featherPrefabPostInit)
AddPrefabPostInit("feather_robin_winter", featherPrefabPostInit)
