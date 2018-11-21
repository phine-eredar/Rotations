local Buffed = PhineRotations.Buffed
local Debuffed = PhineRotations.Debuffed
local Not = PhineRotations.Not
local Power = PhineRotations.Power
local Rotation = PhineRotations.Rotation

function PhineRotations:ElementalShaman()
  local talents = {}

  local single = Rotation()
  single.use("Totem Mastery").when(Not(Buffed("Resonance Totem")))
  single.use("Flame Shock").when(Not(Debuffed("Flame Shock", 6)))
  single.use("Liquid Magma Totem")
  single.use("Earth Shock").when(Power(">=", 90, 11))
  single.use("Lava Burst").when(Debuffed("Flame Shock"))
  single.use("Earth Shock").when(Power(">=", 60, 11))
  single.use("Lightning Bolt")

  local multi = Rotation()
  multi.use("Totem Mastery").when(Not(Buffed("Resonance Totem")))
  multi.use("Flame Shock").when(Not(Debuffed("Flame Shock", 6)))
  multi.use("Liquid Magma Totem")
  multi.use("Earhquake").when(Power(">=", 60, 11))
  multi.use("Lava Burst").when(Debuffed("Flame Shock"))
  multi.use("Chain Lightning")

  return {
    talents = function() return talents end,
    single = function() return single.get() end,
    multi = function() return multi.get() end
  }
end
