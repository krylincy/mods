require "behaviours/wander"
require "behaviours/doaction"
require "behaviours/panic"
require "behaviours/minperiod"

local FOOD_TAGS = {"edible"}
local NO_TAGS = {"FX", "NOCLICK", "DECOR", "INLIMBO", "AQUATIC"}

local function EatFoodAction(inst)  --Look for food to eat
	local target = nil
	local action = nil
	local hasEaten = false

	if inst.sg:HasStateTag("busy") and not inst.sg:HasStateTag("wantstoeat") then
		return
	end	
	
	local time_since_eat = inst.components.eater:TimeSinceLastEating()	
	if time_since_eat == nil or time_since_eat > TUNING.DOYDOYPET_EAT_INVERVALL then
	
		if inst.components.inventory and inst.components.eater then	
			
			target = inst.components.inventory:FindItem(function(item) return inst.components.eater:CanEat(item) end)
			if target then 
				return BufferedAction(inst,target,ACTIONS.EAT) 
			end
		end
	
		local pt = inst:GetPosition()
		local ents = TheSim:FindEntities(pt.x, pt.y, pt.z, TUNING.DOYDOYPET_SEE_FOOD_DIST, FOOD_TAGS, NO_TAGS) 

		if not target then
			for k,v in pairs(ents) do
				if v and v:IsOnValidGround() and 
				inst.components.eater:CanEat(v) and
				v:GetTimeAlive() > 5 then
					target = v
					break
				end
			end
		end    

		if target then
			local action = BufferedAction(inst,target,ACTIONS.EAT)
			return action 
		else			
			local ents = TheSim:FindEntities(pt.x, pt.y, pt.z,  TUNING.DOYDOYPET_SEE_FOOD_DIST, nil, NO_TAGS) 
			-- eat from seed grass
			for k,item in pairs(ents) do		
				if item.components.pickable and 
				item.components.pickable.caninteractwith and 
				item.components.pickable:CanBePicked() and
				item:HasTag("doydoypetfood") then
					target = item
					break
				end
			end
		end

		if target then
			return BufferedAction(inst, target, ACTIONS.PICK)
		end
		
		if time_since_eat == nil or time_since_eat > (TUNING.DOYDOYPET_EAT_INVERVALL * 2) then	
			if inst.components.health.currenthealth > 35 then
				inst.components.talker:Say("Hungry", 3)
			else
				inst.components.talker:Say("Starving", 3)
			end
			
			inst.components.health:DoDelta(-2)	
			return
		end
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
		lifespan = math.floor(inst.eatTimes * 10 / TUNING.DOYDOYPET_DIE_OLD_AGE)
		--lifespan = inst.eatTimes..'/'..TUNING.DOYDOYPET_DIE_OLD_AGE
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

local function checkAgeAction(inst)		
	
	
	if inst.eatTimes > TUNING.DOYDOYPET_TO_TEEN and inst:HasTag("baby") then
		inst.components.growable:DoGrowth()
		inst.components.growable:SetStage(2)
	end
	
	if inst.eatTimes > TUNING.DOYDOYPET_TO_ADULT and inst:HasTag("teen") then
		inst.components.growable:DoGrowth()
		inst.components.growable:SetStage(3)
	end 
	
	local calculateLimit = (inst.eatTimes - TUNING.DOYDOYPET_DIE_OLD_AGE) / TUNING.DOYDOYPET_EAT_INVERVALL
	
	if calculateLimit > math.random(0, 5) then
		--inst.components.talker:Say("It's time to go", 3)
		--GetPlayer().components.talker:Say("I suddenly feel sad …")
		inst.components.lootdropper:SetLoot({'meat', 'meat', 'trinket_19'})
		
		if not inst:HasTag("doydoypet_female") then
			local gem_prefab = {
				"goldnugget",
				"goldnugget",
				"goldnugget",
				"redgem",
				"redgem",
				"redgem",
				"bluegem",
				"bluegem",
				"bluegem",
				"purplegem",
				"purplegem",
				"greengem",
				"orangegem",
				"yellowgem",
				"goldnugget",
				"goldnugget",
				"goldnugget",
			}
			
			local selectGem = math.random(1, 17)
			
			--SpawnPrefab(gem_prefab[selectGem]).Transform:SetPosition(inst.Transform:GetWorldPosition())	
			--inst.SoundEmitter:PlaySound("dontstarve/common/dropGeneric")		
			inst.components.lootdropper:SetLoot({gem_prefab[selectGem]})			
		end
		
		inst.components.health:DoDelta(-1 * TUNING.DOYDOYPET_HEALTH)
	end 
	
	updateDescription(inst)
end

local DoydoyBrain = Class(Brain, function(self, inst)
	Brain._ctor(self, inst)
end)

function DoydoyBrain:OnStart()

	local clock = GetClock()
	local checkAgeNode =
	PriorityNode(
	{
		DoAction(self.inst, checkAgeAction),
	}, 25)	
		
	local root =
	PriorityNode(
	{
		WhileNode(function() return self.inst.components.health.takingfiredamage end, "OnFire", Panic(self.inst)),		 
		DoAction(self.inst, EatFoodAction),
		MinPeriod(self.inst, math.random(4,6), checkAgeNode),
		Wander(self.inst, function() return self.inst.components.knownlocations:GetLocation("home") end, TUNING.DOYDOYPET_MAX_WANDER_DIST),
	},1)
	
	self.bt = BT(self.inst, root) 
		
end

function DoydoyBrain:OnInitializationComplete()
	if self.inst.components.knownlocations:GetLocation("home") == nil then
		self.inst.components.knownlocations:RememberLocation("home", Point(self.inst.Transform:GetWorldPosition()), true)
	end	
end

return DoydoyBrain
