local Buffed = PhineRotations.Buffed
local Debuffed = PhineRotations.Debuffed
local Not = PhineRotations.Not
local Rotation = PhineRotations.Rotation

function PhineRotations:BalanceDruid()
  local talents = {}

  local single = Rotation()
  single.use("Moonfire").when(Not(Debuffed("Moonfire")))
  single.use("Sunfire").when(Not(Debuffed("Sunfire")))
  single.use("Solar Wrath").when(Buffed("Solar Empowerment"))
  single.use("Lunar Strike").when(Buffed("Lunar Empowerment"))
  single.use("Starsurge")
  single.use("Solar Wrath")

  local multi = Rotation()
  multi.use("Starfall")
  multi.use("Sunfire").when(Not(Debuffed("Sunfire")))
  multi.use("Moonfire").when(Not(Debuffed("Moonfire")))
  multi.use("Lunar Strike").when(Buffed("Lunar Empowerment"))
  multi.use("Solar Wrath").when(Buffed("Solar Empowerment"))
  multi.use("Lunar Strike")

  return {
    talents = function() return talents end,
    single = function() return single.get() end,
    multi = function() return multi.get() end
  }
end
