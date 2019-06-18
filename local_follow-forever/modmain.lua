require = GLOBAL.require
------------------------------------------------------
-- Load the custom actions
--require('actions/actions')

GLOBAL.ACTIONS.FF_GOODBYE = {
	id = "FF_GOODBYE",
    priority = 1,
    strfn = nil,
    testfn = nil,
    instant = false,
    rmb = true,
    distance = 3,
}

GLOBAL.ACTIONS.FF_GOODBYE.fn = function(act)
	local inst = act.target

    if inst:IsValid() and inst.components.follower then
		inst:PushEvent("loseloyalty", {leader=inst.components.follower.leader})
		inst.components.follower:SetLeader(nil)
		--inst.components.locomotor.runspeed = 6
		--inst.components.locomotor.walkspeed = 4

		if act.doer.components.talker then
	        act.doer.components.talker:Say("Goodbye my friend!")
	    end
	end

    return true
end

GLOBAL.STRINGS.ACTIONS.FF_GOODBYE = "Goodbye"
AddStategraphActionHandler("wilson", GLOBAL.ActionHandler(GLOBAL.ACTIONS.FF_GOODBYE))



------------------------------------------------------

local function custom_follower(inst)

	function GetLoyaltyPercentOverwrite(self)
	    return 1
	end

	function AddLoyaltyTimeOverwrite(self, time)    
	    local currentTime = GLOBAL.GetTime()
	    local timeLeft = self.targettime or 0
	    timeLeft = math.max(0, timeLeft - currentTime)
	    timeLeft = math.min(self.maxfollowtime or 0, timeLeft + time)

	    self.targettime = currentTime + timeLeft

		if self.task then
			self.task:Cancel()
			self.task = nil
		end

		if self.inst and self.inst.components.locomotor.runspeed then
			--self.inst.components.locomotor.runspeed = 11
			--self.inst.components.locomotor.walkspeed = 11
		end

	end

	function CollectSceneActions(self, doer, actions, right)
	    if right and self.inst.components.follower and self.inst.components.follower.leader == doer then
	        table.insert(actions, GLOBAL.ACTIONS.FF_GOODBYE)
	    end

	end

	function OnLoadOverwrite(self, data)
		function tdump ( tab, indent )
		   if indent == nil then indent = "" end
		   indent = indent.."  "
		   if type (tab) ~= "table" then
		      print ("invoke with a table, you sent me a: ",type (tab) )
		      return
		   end
		   for k,v in pairs (tab) do
		      if type (v) == "table" then
		         print (indent,k," <TABLE>")
		         tdump (v, indent)
		      else
		         print (indent,k," = ",v)
		      end
		   end
		end

		tdump(data)

	    if data.time then
	        self:AddLoyaltyTime(data.time)
	    end

	    if self.inst and self.inst.components.locomotor.runspeed then
	    	print('speed UUUUP')
			--self.inst.components.locomotor.runspeed = 11
			--self.inst.components.locomotor.walkspeed = 7
		end
	end

	inst.GetLoyaltyPercent = GetLoyaltyPercentOverwrite
	inst.AddLoyaltyTime = AddLoyaltyTimeOverwrite
	inst.CollectSceneActions = CollectSceneActions
	inst.OnLoad = OnLoadOverwrite
end

AddComponentPostInit("follower", custom_follower)

GLOBAL.TUNING.BUNNYMAN_SEE_MEAT_DIST = 0


AddPrefabPostInit("merm", function(inst) inst:AddTag("monster") end)
AddPrefabPostInit("mosquito", function(inst) inst:AddTag("monster") end)
AddPrefabPostInit("worm", function(inst) inst:AddTag("monster") end)
AddPrefabPostInit("tallbird", function(inst) inst:AddTag("monster") end)
AddPrefabPostInit("frog", function(inst) inst:AddTag("monster") end)
AddPrefabPostInit("killerbee", function(inst) inst:AddTag("monster") end)
AddPrefabPostInit("ghost", function(inst) inst:AddTag("monster") end)
AddPrefabPostInit("leif", function(inst) inst:AddTag("monster") end)
AddPrefabPostInit("perd", function(inst) inst:AddTag("monster") end)

AddPrefabPostInit("mosquito_poison", function(inst) inst:AddTag("monster") end)
AddPrefabPostInit("dragoon", function(inst) inst:AddTag("monster") end)
AddPrefabPostInit("swordfish", function(inst) inst:AddTag("monster") end)
AddPrefabPostInit("snake", function(inst) inst:AddTag("monster") end)
AddPrefabPostInit("flup", function(inst) inst:AddTag("monster") end)

