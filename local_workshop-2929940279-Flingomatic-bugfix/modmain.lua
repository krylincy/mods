STRINGS = GLOBAL.STRINGS

modimport('scripts/crop_bugfix.lua')
modimport('scripts/pickable_bugfix.lua')
if GLOBAL.IsDLCEnabled(GLOBAL.CAPY_DLC) or GLOBAL.IsDLCEnabled(GLOBAL.PORKLAND_DLC) then
	--modimport('scripts/hackable_bugfix.lua')
end
modimport('scripts/firedetector_bugfix.lua')
modimport('scripts/firesuppressor_bugfix.lua')
modimport('scripts/berrybush_bugfix.lua')
if GLOBAL.IsDLCEnabled(GLOBAL.CAPY_DLC) or GLOBAL.IsDLCEnabled(GLOBAL.PORKLAND_DLC) then
	modimport('scripts/seaweed_planted_bugfix.lua')
	modimport('scripts/limpetrock_bugfix.lua')
end
if GLOBAL.IsDLCEnabled(GLOBAL.PORKLAND_DLC) then
	--modimport('scripts/rock_flippable_bugfix.lua')
end

local function PlayerControllerPostConstruct(self)
	self.DoInspectButton = function(self)
		if self.controller_target and GLOBAL.GetPlayer():CanExamine() then
			local pickable = self.controller_target.components.crop or self.controller_target.components.pickable or self.controller_target.components.hackable
			if pickable then
				print(self.controller_target, pickable:GetDebugString())
			end

			self.inst.components.locomotor:PushAction( GLOBAL.BufferedAction(self.inst, self.controller_target, GLOBAL.ACTIONS.LOOKAT))
		end
		return true
	end
end
AddClassPostConstruct("components/playercontroller", PlayerControllerPostConstruct)

local function EntityScriptPostConstruct(self)
	local origin_GetDisplayName = self.GetDisplayName
	self.GetDisplayName = function(self)
		if self.components.hackable and self.components.hackable:IsWithered() then
			local player = GLOBAL.GetPlayer()
			if player.components.vision == nil or player.components.vision.focused or player.components.vision:testsight(self) then
				local name = self.displaynamefn and self:displaynamefn() or self.nameoverride and STRINGS.NAMES[string.upper(self.nameoverride)] or self.name
				return GLOBAL.ConstructAdjectivedName(self, name, STRINGS.WITHEREDITEM)
			end
		end
		return origin_GetDisplayName(self)
	end
end
AddGlobalClassPostConstruct("entityscript","EntityScript", EntityScriptPostConstruct)
