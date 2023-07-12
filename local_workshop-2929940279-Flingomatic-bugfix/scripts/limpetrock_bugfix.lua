local function LimpetRockPostInit(self)
	self:AddTag("bush")
	self:RemoveTag("fire_proof")
end
AddPrefabPostInit("limpetrock", LimpetRockPostInit)
