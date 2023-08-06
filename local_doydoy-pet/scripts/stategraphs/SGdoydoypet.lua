require("stategraphs/commonstates")

local actionhandlers = 
{
	ActionHandler(ACTIONS.EAT, "eat_loop"),
	ActionHandler(ACTIONS.PICKUP, "action"),
	ActionHandler(ACTIONS.HARVEST, "action"),
	ActionHandler(ACTIONS.PICK, "action"),
}

local events=
{
	EventHandler("gotosleep", function(inst)
		if not inst.onwater and inst.components.health and inst.components.health:GetPercent() > 0 then
			if inst.sg:HasStateTag("sleeping") then
				inst.sg:GoToState("sleeping")
			else
				inst.sg:GoToState("sleep")
			end
		end
	end),


	EventHandler("freeze", function(inst)
		if not inst.onwater and inst.components.health and inst.components.health:GetPercent() > 0 then
			inst.sg:GoToState("frozen")
		end
	end),

	
	EventHandler("attacked", function(inst)
		if not inst.onwater and inst.components.health and not inst.components.health:IsDead()
			and (not inst.sg:HasStateTag("busy") or inst.sg:HasStateTag("frozen") ) then
			inst.sg:GoToState("hit")
		end
	end),

	EventHandler("death", function(inst)
		inst.sg:GoToState("death")
	end),

	EventHandler("locomote", function(inst)
		local is_moving = inst.sg:HasStateTag("moving")
		local is_idling = inst.sg:HasStateTag("idle")
		local should_move = inst.components.locomotor:WantsToMoveForward()
		
		if (is_moving and not should_move) then
			inst.sg:GoToState("walk_stop")
		elseif (is_idling and should_move) or (is_moving and should_move ) then
			if not is_moving then
				inst.sg:GoToState("walk_start")
			end
		end
	end),
}

local states=
{   

	State{
		
		name = "idle",
		tags = {"idle", "canrotate"},
		onenter = function(inst, playanim)
			inst.Physics:Stop()
			inst.AnimState:PlayAnimation("idle")
			inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/doy_doy/idle")
		end,        
	  
		events=
		{
			EventHandler("animover", function(inst)
				if math.random() < 0.25 then
					inst.sg:GoToState("peck")
				else
					inst.sg:GoToState("idle")
				end
			end),
		},
	},

	State{
		name = "action",
		tags = {"busy"},
		
		onenter = function(inst)
			inst.Physics:Stop()
			inst.AnimState:PushAnimation("eat_pre", false)
			inst.sg:SetTimeout(math.random()*2+1)
			inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/doy_doy/eat_pre")
		end,
		
		timeline=
		{
			-- TimeEvent(7*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve_DLC001/creatures/mossling/eat") end),
			
			TimeEvent(20*FRAMES, function(inst)
				inst:PerformBufferedAction()
				inst.sg:RemoveStateTag("busy")
				inst.brain:ForceUpdate()
				inst.sg:AddStateTag("wantstoeat")
			end),
		},

		events =
		{
			EventHandler("animqueueover", function(inst) inst.sg:GoToState("eat_pst") end)
		},

		ontimeout = function(inst)
			inst.sg:GoToState("eat_pst") 
		end,
	},

	State{
		name = "eat_loop",
		tags = {"busy"},
		
		onenter = function(inst)
			inst.Physics:Stop()
			inst.AnimState:PushAnimation("eat", false)
		end,
		
		timeline = 
		{
			TimeEvent(22*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/doy_doy/swallow") end),
		},

		events =
		{
			EventHandler("animover", function(inst) 
				inst:PerformBufferedAction()  
			end),

			EventHandler("animqueueover", function(inst) 
				inst.sg:GoToState("eat_pst") 
			end)
		},
	},

	State{
		name = "eat_pst",
		tags = {"busy"},
		
		onenter = function(inst)
			inst.Physics:Stop()
			inst.AnimState:PlayAnimation("eat_pst")
			inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/doy_doy/swallow")
		end,
		
		events =
		{
			EventHandler("animover", function(inst) inst.sg:GoToState("idle") end),
		},
	},

	State{
		name = "peck",
		tags = {"busy"},
		
		onenter = function(inst)
			inst.Physics:Stop()
			inst.AnimState:PlayAnimation("peck")

			inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/doy_doy/peck")
		end,
		
		timeline = 
		{
			TimeEvent(10*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/doy_doy/peck") end),
		},

		events=
		{
			EventHandler("animover", function(inst) inst.sg:GoToState("idle") end),
		},
	},

	State{
		name = "hatch",
		tags = {"busy"},
		
		onenter = function(inst)
			local angle = math.random()*2*PI
			local speed = GetRandomWithVariance(3, 2)
			inst.Physics:SetMotorVel(speed*math.cos(angle), 0, speed*math.sin(angle))
			inst.AnimState:PlayAnimation("hatch")
		end,

		timeline =
		{
			-- TimeEvent(FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve_DLC001/creatures/mossling/hatch") end),
			TimeEvent(20*FRAMES, function(inst) inst.Physics:SetMotorVel(0,0,0) end),
			-- TimeEvent(47*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve_DLC001/creatures/mossling/pop") end)
		},
		
		events=
		{
			EventHandler("animover", function(inst) inst.sg:GoToState("idle") end),
		},
	},
}

CommonStates.AddFrozenStates(states)
CommonStates.AddWalkStates(states, 
{
	walktimeline =
	{
		TimeEvent(FRAMES, function(inst) PlayFootstep(inst) end),
		TimeEvent(5*FRAMES, function(inst) PlayFootstep(inst) end),
		TimeEvent(10*FRAMES, function(inst) PlayFootstep(inst) end),
	}
})
CommonStates.AddCombatStates(states,
{
	attacktimeline = 
	{
		TimeEvent(20*FRAMES, function(inst)
			inst.components.combat:DoAttack(inst.sg.statemem.target, nil, nil, "electric")
		end),
		-- TimeEvent(20*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve_DLC001/creatures/mossling/attack") end),
		TimeEvent(22*FRAMES, function(inst) inst.sg:RemoveStateTag("attack") end),
	},

	deathtimeline = 
	{
		TimeEvent(FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/doy_doy/death") end)
	},
})
CommonStates.AddSleepStates(states, 
{
	starttimeline =
	{
		TimeEvent( 7*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/doy_doy/yawn") end)
	},
	sleeptimeline = 
	{
		TimeEvent(25*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/doy_doy/sleep") end)
	},
	waketimeline =
	{
		-- TimeEvent(10*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve_DLC001/creatures/mossling/hatch") end)
	}
})
	
return StateGraph("doydoypet", states, events, "idle", actionhandlers)

