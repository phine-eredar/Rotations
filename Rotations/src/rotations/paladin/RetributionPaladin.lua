local Power = PhineRotations.Power
local Rotation = PhineRotations.Rotation

function PhineRotations:RetributionPaladin()
  local talents = {}

  local single = Rotation()
  single.use("Avenging Wrath")
  single.use("Templar's Verdict").when(Power(">=", 5, 9))
  single.use("Wake of Ashes")
  single.use("Blade of Justice")
  single.use("Judgment")
  single.use("Crusader Strike")

  local multi = Rotation()
  multi.use("Avenging Wrath")
  multi.use("Divine Storm").when(Power(">=", 5, 9))
  multi.use("Wake of Ashes")
  multi.use("Blade of Justice")
  multi.use("Judgment")
  multi.use("Crusader Strike")

  return {
    talents = function() return talents end,
    single = function() return single.get() end,
    multi = function() return multi.get() end
  }
end
