local Combo = PhineRotations.Combo
local Debuffed = PhineRotations.Debuffed
local Not = PhineRotations.Not
local Power = PhineRotations.Power
local POWER = PhineRotations.POWER
local Rotation = PhineRotations.Rotation

function PhineRotations:FeralDruid()
  local talents = {}

  local single = Rotation()
  single.use("Tiger's Fury").when(Power("<", 30, POWER.ENERGY))
  single.use("Berserk")
  single.use("Ferocious Bite").whenAll(Combo(">=", 5), Debuffed("Rip"))
  single.use("Rip").whenAll(Combo(">=", 5), Not(Debuffed("Rip")))
  single.use("Rake").when(Not(Debuffed("Rake")))
  single.use("Brutal Slash")
  single.use("Shred")

  local multi = Rotation()
  multi.use("Tiger's Fury").when(Power("<", 30, POWER.ENERGY))
  multi.use("Berserk")
  multi.use("Ferocious Bite").whenAll(Combo(">=", 5), Debuffed("Rip"))
  multi.use("Rip").whenAll(Combo(">=", 5), Not(Debuffed("Rip")))
  multi.use("Rake").when(Not(Debuffed("Rake")))
  multi.use("Thrash").when(Not(Debuffed("Thrash")))
  multi.use("Brutal Slash")
  multi.use("Shred")

  return {
    talents = function() return talents end,
    single = function() return single.get() end,
    multi = function() return multi.get() end
  }
end
