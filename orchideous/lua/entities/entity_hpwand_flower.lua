AddCSLuaFile()

ENT.Base = "base_anim"
ENT.Type = "anim"

local model = Model("models/rosesbouquetmodel/roses_bouquet.mdl")


if SERVER then
	function ENT:Initialize()
		self:SetModel(model)
		--self:SetMaterial("models/props_combine/portalball001_sheet")
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)

		local phys = self:GetPhysicsObject()
		if not phys:IsValid() then self:Remove() return end

		self:SetModelScale(2, 2)

		SafeRemoveEntityDelayed(self, 60)
	end
end