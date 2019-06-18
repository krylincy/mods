local require = GLOBAL.require

local function AddEnableMouseWithController( inst )

  if GLOBAL.TheInput.ControllerAttached then
    local input_enablemouse_base = GLOBAL.TheInput.EnableMouse
    GLOBAL.TheInput.EnableMouse = function(self, enable)
      self.mouse_enabled = true
      return true
    end
  else
    return
  end

  local ismouse = false

  local playercontroller = inst.components.playercontroller

  local playercontroller_usingmouse_base = playercontroller.UsingMouse
  playercontroller.UsingMouse = function(self)
    return true
  end

  local input_onmousemove_base = GLOBAL.TheInput.OnMouseMove
  GLOBAL.TheInput.OnMouseMove = function(self, x,y)
    input_onmousemove_base(self, x,y)

    local new_highlight = nil
    playercontroller.LMBaction, playercontroller.RMBaction = playercontroller.inst.components.playeractionpicker:DoGetMouseActions()
    new_highlight = (playercontroller.LMBaction and playercontroller.LMBaction.target) or (playercontroller.RMBaction and playercontroller.RMBaction.target)

    if new_highlight ~= playercontroller.highlight_guy_mouse then
      if playercontroller.highlight_guy_mouse and playercontroller.highlight_guy_mouse:IsValid() then
        if playercontroller.highlight_guy_mouse.components.highlight then
          playercontroller.highlight_guy_mouse.components.highlight:UnHighlight()
        end
      end
      playercontroller.highlight_guy_mouse = new_highlight
    end

    if playercontroller.highlight_guy_mouse and playercontroller.highlight_guy_mouse:IsValid() then
      if not playercontroller.highlight_guy_mouse.components.highlight then
        playercontroller.highlight_guy_mouse:AddComponent("highlight")
      end


      local override = playercontroller.highlight_guy_mouse.highlight_override
      if override then
        playercontroller.highlight_guy_mouse.components.highlight:Highlight(override[1], override[2], override[3])
      else
        playercontroller.highlight_guy_mouse.components.highlight:Highlight()
      end
    else
      playercontroller.highlight_guy_mouse = nil
    end

  end

  local input_controllerattached = GLOBAL.TheInput.ControllerAttached
  GLOBAL.TheInput.ControllerAttached = function(self)
    if ismouse then
      return false
    end
    return input_controllerattached(self)
  end

  local theinput_oncontrol_base = GLOBAL.TheInput.OnControl
  GLOBAL.TheInput.OnControl = function(self, control, digitalvalue, analogvalue)
    if control == GLOBAL.CONTROL_PRIMARY then
      ismouse = true
    end
    if control == GLOBAL.CONTROL_SECONDARY then
      ismouse = true
    end
    theinput_oncontrol_base(self, control, digitalvalue, analogvalue)
  end

--  local playercontroller_onupdate_base = playercontroller.OnUpdate
--  playercontroller.OnUpdate = function(self, dt)
--    local active_slot_save = inst.HUD.controls.inv.active_slot
--    if ismouse then
--      inst.HUD.controls.inv.active_slot = nil
--    end
--    playercontroller_onupdate_base(self, dt)
--    if ismouse then
--      inst.HUD.controls.inv.active_slot = active_slot_save
--    end
--  end

  local function OnUpdate(dt)
    if inst.sg.currentstate == inst.sg.sg.states["idle"]
       and ismouse
       and not playercontroller.inst.components.inventory.activeitem
       and not playercontroller.placer
    then
      --print("IDLE !!!")
      ismouse = false
      playercontroller:CancelDeployPlacement()
    end
  end

  local task

  local function StopUpdating()
    if task then
      task:Cancel()
      task = nil
    end
  end

  local function StartUpdating()
    if not task then
        local dt = .5
        task = inst:DoPeriodicTask(dt, function() OnUpdate(dt) end, dt + math.random()*.67)
    end
  end

  StartUpdating()

end

AddSimPostInit( AddEnableMouseWithController )
