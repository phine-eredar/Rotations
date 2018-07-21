local Buffed = PhineRotations.Buffed
local Not = PhineRotations.Not
local Power = PhineRotations.Power
local Rotation = PhineRotations.Rotation
local Talented = PhineRotations.Talented

function PhineRotations:FuryWarrior()
  local talents = {
    ["Inner Rage"] = { tier = 6, column = 3 },
    Massacre = { tier = 5, column = 1 }
  }

  local single = Rotation()
  single.use("Rampage").whenAny(Not(Buffed("Enrage")), Power(">=", 100))
  single.use("Bloodthirst").when(Not(Buffed("Enrage")))
  single.use("Execute").when(Talented("Massacre"))
  single.use("Whirlwind").when(Buffed("Wrecking Ball"))
  single.use("Execute").whenAll(Not(Talented("Massacre")), Buffed("Enrage"))
  single.use("Raging Blow").whenAny(Talented("Inner Rage"), Buffed("Enrage"))
  single.use("Bloodthirst")
  single.use("Furious Slash")

  local multi = Rotation()
  multi.use("Whirlwind").when(Not(Buffed("Meat Cleaver")))
  multi.use("Rampage").whenAny(Not(Buffed("Enrage")), Power("<=", 100))
  multi.use("Bloodthirst").when(Not(Buffed("Enrage")))
  multi.use("Whirlwind").when(Buffed("Wrecking Ball"))
  multi.use("Raging Blow")
  multi.use("Bloodthirst")
  multi.use("Whirlwind")

  return {
    talents = function() return talents end,
    single = function() return single.get() end,
    multi = function() return multi.get() end
  }
end
