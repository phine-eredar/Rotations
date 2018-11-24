local Charges = PhineRotations.Charges
local Power = PhineRotations.Power
local Rotation = PhineRotations.Rotation

function PhineRotations:DemonologyWarlock()
  local talents = {}

  local single = Rotation()
  single.use("Call Dreadstalkers")
  single.use("Hand of Gul'dan").when(Power(">=", 4, 7))
  single.use("Demonbolt").when(Charges(">=", 2, "Demonic Core"))
  single.use("Soul Strike")
  single.use("Hand of Gul'dan").when(Power(">=", 3, 7))
  single.use("Shadow Bolt")

  local multi = Rotation()

  return {
    talents = function() return talents end,
    single = function() return single.get() end,
    multi = function() return multi.get() end
  }
end
