local Buffed = PhineRotations.Buffed
local Charges = PhineRotations.Charges
local Cooldown = PhineRotations.Cooldown
local Debuffed = PhineRotations.Debuffed
local Not = PhineRotations.Not
local Power = PhineRotations.Power
local POWER = PhineRotations.POWER
local Rotation = PhineRotations.Rotation

function PhineRotations:ArmsWarrior()
  local talents = {}

  local single = Rotation()
  single.use("Battle Shout").when(Not(Buffed("Battle Shout")))
  single.use("Rend").whenAll(Not(Debuffed("Colossus Smash")), Not(Debuffed("Rend")))
  single.use("Avatar").when(Cooldown("Warbreaker", "<=", 8))
  single.use("Warbreaker")
  single.use("Overpower").when(Charges("==", 2))
  single.use("Mortal Strike").when(Charges("==", 2, "Overpower"))
  single.use("Skullsplitter").when(Power("<", 60, POWER.RAGE))
  single.use("Overpower")
  single.use("Mortal Strike")
  single.use("Slam")

  local multi = Rotation()
  multi.use("Sweeping Strikes").whenAll(Cooldown("Bladestorm", ">", 15), Cooldown("Warbreaker", ">", 15))
  multi.use("Avatar").when(Cooldown("Warbreaker", "==", 0))
  multi.use("Warbreaker")
  multi.use("Bladestorm").when(Debuffed("Colossus Smash"))
  multi.use("Execute").when(Buffed("Sweeping Strikes"))
  multi.use("Whirlwind").when(Debuffed("Colossus Smash"))
  multi.use("Overpower")
  multi.use("Whirlwind")

  return {
    talents = function() return talents end,
    single = function() return single.get() end,
    multi = function() return multi.get() end
  }
end
