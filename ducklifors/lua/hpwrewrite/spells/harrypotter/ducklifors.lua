local Spell = { }
Spell.LearnTime = 300
Spell.Category = HpwRewrite.CategoryNames.Physics
Spell.Description = [[
	Turns organisms
	to ducks.
]]
Spell.ApplyDelay = 0.4
Spell.ForceDelay = 1
--Spell.CanSelfCast = false
Spell.ForceAnim = { ACT_VM_PRIMARYATTACK_5 }
Spell.SpriteColor = Color(255, 255, 0)
Spell.AccuracyDecreaseVal = 0.1


local isDuck = false
function Spell:OnFire(wand)

	local ent = wand:HPWGetAimEntity(300, Vector(-10, -10, -10), Vector(10, 10, 10))

	if (ent:IsPlayer() or ent:IsNPC()) and not isDuck then

		isDuck = true
		local oldModel = ent:GetModel()
		ent:SetModelScale(ent:GetModelScale() * 0.3, 1)

		timer.Simple(1, function()

			ent:SetModel("models/TSBB/Animals/Duck.mdl")
			ent:SetModelScale(1)
			ent:SetActiveWeapon(weapon_empty_hands) -- Empty Hands Swep https://steamcommunity.com/sharedfiles/filedetails/?id=245482078
			sound.Play("hpwrewrite/spells/duck.wav", ent:GetPos())

			hook.Add("PlayerSwitchWeapon", "NoWeapon", function(ply)
				if ply == ent then return true end
			end)
			hook.Add("PlayerCanHearPlayersVoice", "Quack", function(ply)
				if ply == ent then return false end
			end)
			hook.Add("canSleep", "NoSleep", function(ply)
				if ply == ent then return false end
			end)

			timer.Simple(10, function()

				ent:SetModelScale(ent:GetModelScale() * 3, 1)

				timer.Simple(1, function()
					ent:SetModel(oldModel)
					ent:SetModelScale(1)
					hook.Remove("PlayerSwitchWeapon", "NoWeapon")
					hook.Remove("PlayerCanHearPlayersVoice", "Quack")
					hook.Remove("canSleep", "NoSleep")
					isDuck = false
				end)
			end)
		end)
	end
end

HpwRewrite:AddSpell("Ducklifors", Spell)