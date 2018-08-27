local Debuffed = PhineRotations.Debuffed
local Not = PhineRotations.Not
local Power = PhineRotations.Power
local Rotation = PhineRotations.Rotation

function PhineRotations:ElementalShaman()
  local talents = {}

  local single = Rotation()
  single.use("Flame Shock").when(Not(Debuffed("Flame Shock")))
  single.use("Fire Elemental")
  single.use("Earth Shock").when(Power(">=", 60, 11))
  single.use("Lava Burst")
  single.use("Lightning Bolt")

  local multi = Rotation()
  multi.use("Fire Elemental")
  multi.use("Earthquake")
  multi.use("Chain Lightning")

  return {
    talents = function() return talents end,
    single = function() return single.get() end,
    multi = function() return multi.get() end
  }
end
