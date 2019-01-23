local Debuffed = PhineRotations.Debuffed
local Totem = PhineRotations.Totem
local Not = PhineRotations.Not
local Power = PhineRotations.Power
local Rotation = PhineRotations.Rotation

function PhineRotations:ElementalShaman()
  local talents = {}

  local single = Rotation()
  single.use("Flame Shock").when(Not(Debuffed("Flame Shock", 6)))
  single.use("Earth Elemental").when(Not(Totem()))
  single.use("Fire Elemental").when(Not(Totem()))
  single.use("Earth Shock").when(Power(">=", 60, 11))
  single.use("Lava Burst").when(Debuffed("Flame Shock"))
  single.use("Lightning Bolt")

  local multi = Rotation()
  multi.use("Fire Elemental").when(Not(Totem()))
  multi.use("Earth Elemental").when(Not(Totem()))
  multi.use("Earthquake").when(Power(">=", 60, 11))
  multi.use("Chain Lightning")

  return {
    talents = function() return talents end,
    single = function() return single.get() end,
    multi = function() return multi.get() end
  }
end
