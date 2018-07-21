local Debuffed = PhineRotations.Debuffed
local Rotation = PhineRotations.Rotation

function PhineRotations:ArmsWarrior()
  local talents = {}

  local single = Rotation()
  single.use("Warbreaker")
  single.use("Bladestorm").when(Debuffed("Colossus Smash"))
  single.use("Execute")
  single.use("Mortal Strike")
  single.use("Overpower")
  single.use("Whirlwind")

  local multi = Rotation()
  multi.use("Warbreaker")
  multi.use("Bladestorm").when(Debuffed("Colossus Smash"))
  multi.use("Sweeping Strikes")
  multi.use("Execute")
  multi.use("Mortal Strike")
  multi.use("Overpower")
  multi.use("Whirlwind")

  return {
    talents = function() return talents end,
    single = function() return single.get() end,
    multi = function() return multi.get() end
  }
end
