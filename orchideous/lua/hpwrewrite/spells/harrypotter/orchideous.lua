local Spell = { }
Spell.LearnTime = 300
Spell.Description = [[
	Conjures a
	bouquet of flowers.
]]

Spell.ApplyDelay = 0.4
Spell.ForceDelay = 1

Spell.ForceAnim = { ACT_VM_PRIMARYATTACK_5 }
Spell.SpriteColor = Color(230, 0, 126)
Spell.LeaveParticles = true
Spell.AccuracyDecreaseVal = 0.1

local delay = 20 --Cooldown
local nextOccurance = 0

function Spell:OnFire(wand)

	local timeleft = nextOccurance - CurTime()
	if timeleft < 0 then
		local pos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * 50

		local a = ents.Create("entity_hpwand_flower")
		a:SetPos(pos)
		a:SetOwner(self.Owner)
		a:SetSkin(math.random(0, 7))

		local dir = (self.Owner:GetEyeTrace().HitPos - pos):GetNormal()
		wand:ApplyAccuracyPenalty(dir)

		a:SetAngles(dir:Angle())
		a:Spawn()

		local phys = a:GetPhysicsObject()
		if not phys:IsValid() then SafeRemoveEntity(a) return end

		phys:ApplyForceOffset(Vector(0, 0, -phys:GetMass() * 0.15), a:GetPos() + a:GetForward() * 20)
		phys:AddAngleVelocity(Vector(0, 5, 0))

		nextOccurance = CurTime() + delay

	else
		self.Owner:ChatPrint("You have to wait another " .. math.Round(nextOccurance - CurTime()) .. " seconds!")
	end

end

HpwRewrite:AddSpell("Orchideous", Spell)