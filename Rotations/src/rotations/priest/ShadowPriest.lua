local Buffed = PhineRotations.Buffed
local Debuffed = PhineRotations.Debuffed
local Not = PhineRotations.Not
local Or = PhineRotations.Or
local Rotation = PhineRotations.Rotation

function PhineRotations:ShadowPriest()
  local talents = {}

  local single = Rotation()
  single.use("Void Eruption").when(Not(Buffed("Voidform")))
  single.use("Vampiric Touch").whenAll(Not(Buffed("Voidform")), Or(Not(Debuffed("Shadow Word: Pain")), Not(Debuffed("Vampiric Touch"))))
  single.use("Void Bolt").when(Buffed("Voidform"))
  single.use("Mind Blast")
  single.use("Mindbender").when(Buffed("Voidform"))
  single.use("Shadowfiend").when(Buffed("Voidform"))
  single.use("Mind Flay")

  local multi = Rotation()

  return {
    talents = function() return talents end,
    single = function() return single.get() end,
    multi = function() return multi.get() end
  }
end