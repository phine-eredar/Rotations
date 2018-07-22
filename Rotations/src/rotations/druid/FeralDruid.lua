local Buffed = PhineRotations.Buffed
local Combo = PhineRotations.Combo
local Debuffed = PhineRotations.Debuffed
local Not = PhineRotations.Not
local Power = PhineRotations.Power
local Rotation = PhineRotations.Rotation

function PhineRotations:FeralDruid()
  local talents = {}

  local single = Rotation()
  single.use("Berserk")
  single.use("Tiger's Fury").whenAny(Power("<", 40, 3), Buffed("Berserk"))
  single.use("Rip").whenAll(Combo(">=", 5), Not(Debuffed("Rip")))
  single.use("Rake").when(Not(Debuffed("Rake")))
  single.use("Ferocious Bite").whenAll(Combo(">=", 5), Debuffed("Rip"))
  single.use("Shred")

  local multi = Rotation()
  multi.use("Berserk")
  multi.use("Tiger's Fury").whenAny(Power("<", 40, 3), Buffed("Berserk"))
  multi.use("Rip").whenAll(Combo(">=", 5), Not(Debuffed("Rip")))
  multi.use("Rake").when(Not(Debuffed("Rake")))
  multi.use("Thrash")
  multi.use("Ferocious Bite").whenAll(Combo(">=", 5), Debuffed("Rip"))
  multi.use("Swipe")
  multi.use("Shred")

  return {
    talents = function() return talents end,
    single = function() return single.get() end,
    multi = function() return multi.get() end
  }
end
