local Spell = { }
Spell.LearnTime = 120
Spell.ApplyFireDelay = 0.4
Spell.Description = [[
	Decreases the size of your
	target's skull.
]]

Spell.OnlyIfLearned = { "Reducio" }
Spell.SpriteColor = Color(255, 0, 0)
Spell.NodeOffset = Vector(-1501, -536, 0)

function Spell:OnFire(wand)
	local ent = wand:HPWGetAimEntity(400)

	if IsValid(ent) and (ent:IsPlayer() or ent:IsNPC()) then
		local bone = ent:LookupBone("ValveBiped.Bip01_Head1")

		if bone then
			local scale = 1
			local name = "hpwrewrite_redactumskullus_handler" .. ent:EntIndex()

			timer.Create(name, 0.1, 5, function()
				if IsValid(ent) then
					scale = scale - 0.1
					ent:ManipulateBoneScale(bone, Vector(scale, scale, scale))

					if scale <= 0.6 then -- wtf (scale <= 0.5) == false
						timer.Simple(5, function()
							timer.Create(name, 0.1, 5, function()
								if IsValid(ent) then
									scale = scale + 0.1
									ent:ManipulateBoneScale(bone, Vector(scale, scale, scale))
								end
							end)
						end)
					end
				end
			end)
		end
	end
end

HpwRewrite:AddSpell("Redactum Skullus", Spell)