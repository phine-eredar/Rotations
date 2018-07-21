local Buffed = PhineRotations.Buffed
local Not = PhineRotations.Not
local Rotation = PhineRotations.Rotation

function PhineRotations:FuryWarrior()
  local talents = {}

  local single = Rotation()
  single.use("Recklessness")
  single.use("Rampage")
  single.use("Execute").when(Buffed("Enrage"))
  single.use("Bloodthirst")
  single.use("Dragon Roar").when(Buffed("Enrage"))
  single.use("Raging Blow")
  single.use("Whirlwind")

  local multi = Rotation()
  multi.use("Recklessness")
  multi.use("Whirlwind").when(Not(Buffed("Whirlwind")))
  multi.use("Rampage")
  multi.use("Execute").when(Buffed("Enrage"))
  multi.use("Bloodthirst")
  multi.use("Dragon Roar").when(Buffed("Enrage"))
  multi.use("Raging Blow")
  multi.use("Whirlwind")

  return {
    talents = function() return talents end,
    single = function() return single.get() end,
    multi = function() return multi.get() end
  }
end
