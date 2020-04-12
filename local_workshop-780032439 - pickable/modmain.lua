require = GLOBAL.require

local KEYP1 = GLOBAL.KEY_SPACE
local TheInput = GLOBAL.TheInput

local Pickable = require "components/pickable"
local mypickablespacebar = Pickable.CanBePicked

function Pickable:CanBePicked()
	local asdf = mypickablespacebar(self)
		if (self.inst.prefab=="flower" or self.inst.prefab=="flower_evil" or self.inst.prefab=="cave_fern" or self.inst.prefab=="carrot_planted" or self.inst.prefab=="mandrake" or self.inst.prefab=="flower_rainforest" or self.inst.prefab=="lantern" or self.inst.prefab=="seed_grass") and TheInput:IsKeyDown(KEYP1) then
			return false
		end
	return asdf
end

local mypickablemouse = Pickable.CollectSceneActions
