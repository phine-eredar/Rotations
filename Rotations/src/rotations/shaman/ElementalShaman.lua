local Buffed = PhineRotations.Buffed
local Charges = PhineRotations.Charges
local Debuffed = PhineRotations.Debuffed
local Name = PhineRotations.Name
local Not = PhineRotations.Not
local Power = PhineRotations.Power
local Rotation = PhineRotations.Rotation
local Totem = PhineRotations.Totem

function PhineRotations:ElementalShaman()
  local talents = {}

  local single = Rotation()
  single.use("Totem Mastery").when(Not(Buffed("Resonance Totem")))
  single.use("Flame Shock").whenAll(Not(Debuffed("Flame Shock", 6)), Charges("<=", 13, "Wind Gust"))
  single.use("Storm Elemental")
  single.use("Earth Elemental").when(Name("pet", nil))
  single.use("Earth Shock").when(Power(">=", 90, 11))
  single.use("Stormkeeper")
  single.use("Lightning Bolt").when(Buffed("Stormkeeper"))
  single.use("Lava Burst").when(Debuffed("Flame Shock"))
  single.use("Totem Mastery").when(Totem(9))
  single.use("Earth Shock").whenAll(Power(">=", 60, 11), Not(Buffed("Lava Surge")))
  single.use("Lightning Bolt")

  local multi = Rotation()
  multi.use("Totem Mastery").when(Not(Buffed("Resonance Totem")))
  multi.use("Flame Shock").when(Not(Debuffed("Flame Shock", 6)))
  multi.use("Earthquake")
  multi.use("Stormkeeper")
  multi.use("Chain Lightning")

  return {
    talents = function() return talents end,
    single = function() return single.get() end,
    multi = function() return multi.get() end
  }
end
