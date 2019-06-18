
local CSW = GLOBAL.rawget(GLOBAL, "CAPY_DLC") and GLOBAL.IsDLCEnabled(GLOBAL.CAPY_DLC)

local prevent_pinecone = GetModConfigData("pinecone")
local prevent_livinglog = GetModConfigData("livinglog")
local prevent_jungletreeseed = GetModConfigData("jungletreeseed")
local prevent_boards = GetModConfigData("boards")
local prevent_palmleaf = GetModConfigData("palmleaf")


if prevent_pinecone then
	AddPrefabPostInit("pinecone", function(inst) inst:RemoveComponent("edible") end)
	AddPrefabPostInit("acorn", function(inst) inst:RemoveComponent("edible") end)
end

if prevent_jungletreeseed then
	AddPrefabPostInit("jungletreeseed", function(inst) inst:RemoveComponent("edible") end)
	AddPrefabPostInit("burr", function(inst) inst:RemoveComponent("edible") end)
	AddPrefabPostInit("teatree_nut", function(inst) inst:RemoveComponent("edible") end)
end

if prevent_livinglog then
	AddPrefabPostInit("livinglog", function(inst) inst:RemoveComponent("edible") end)
end

if prevent_boards then
	AddPrefabPostInit("boards", function(inst) inst:RemoveComponent("edible") end)
end

if prevent_palmleaf then
	AddPrefabPostInit("palmleaf", function(inst) inst:RemoveComponent("edible") end)
end



