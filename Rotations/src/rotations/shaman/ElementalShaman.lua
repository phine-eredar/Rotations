local Buffed = PhineRotations.Buffed
local Debuffed = PhineRotations.Debuffed
local Not = PhineRotations.Not
local Rotation = PhineRotations.Rotation

function PhineRotations:ElementalShaman()
  local talents = {}

  local single = Rotation()
  single.use("Totem Mastery").whenAny(Not(Buffed("Resonance Totem")), Not(Buffed("Storm Totem")), Not(Buffed("Ember Totem")), Not(Buffed("Tailwind Totem")))
  single.use("Flame Shock").when(Not(Debuffed("Flame Shock")))
  single.use("Fire Elemental")
  single.use("Earth Shock")
  single.use("Lava Burst")
  single.use("Lightning Bolt")

  local multi = Rotation()
  multi.use("Fire Elemental")
  multi.use("Stormkeeper")
  multi.use("Earthquake")
  multi.use("Chain Lightning")

  return {
    talents = function() return talents end,
    single = function() return single.get() end,
    multi = function() return multi.get() end
  }
end
