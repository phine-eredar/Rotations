local Buffed = PhineRotations.Buffed
local Cooldown = PhineRotations.Cooldown
local Debuffed = PhineRotations.Debuffed
local Health = PhineRotations.Health
local Not = PhineRotations.Not
local Or = PhineRotations.Or
local Power = PhineRotations.Power
local POWER = PhineRotations.POWER
local Rotation = PhineRotations.Rotation

function PhineRotations:ShadowPriest()
  local talents = {}

  local single = Rotation()
  single.use("Shadowform").when(Not(Buffed('Shadowform')))
  single.use("Devouring Plague").when(Buffed("Voidform"))
  single.use("Void Bolt").when(Buffed("Voidform"))
  single.use("Mindbender").whenAll(Cooldown("Void Eruption", "<", 1), Not(Buffed("Voidform")), Power('>=', 35, POWER.INSANITY))
  single.use("Power Infusion").whenAll(Cooldown("Void Eruption", "<", 1), Not(Buffed("Voidform")), Power('>=', 35, POWER.INSANITY))
  single.use("Void Eruption").whenAll(Not(Buffed("Voidform")), Power('>=', 35, POWER.INSANITY))
  single.use("Vampiric Touch").whenAll(Not(Buffed("Voidform")), Or(Not(Debuffed("Shadow Word: Pain")), Not(Debuffed("Vampiric Touch"))))
  single.use("Mind Blast")
  single.use("Shadow Word: Death").when(Health("<=", 20))
  single.use("Mind Flay")

  local multi = Rotation()

  return {
    talents = function() return talents end,
    single = function() return single.get() end,
    multi = function() return multi.get() end
  }
end