local Buffed = PhineRotations.Buffed
local Charges = PhineRotations.Charges
local Debuffed = PhineRotations.Debuffed
local Not = PhineRotations.Not
local Rotation = PhineRotations.Rotation

function PhineRotations:BloodDeathKnight()
  local talents = {}

  local single = Rotation()
  single.use("Marrowrend").when(Not(Buffed("Bone Shield")))
  single.use("Death Strike")
  single.use("Blooddrinker")
  single.use("Blood Boil").when(Not(Debuffed("Blood Plague")))
  single.use("Marrowrend").when(Charges("<=", 6, "Bone Shield"))
  single.use("Heart Strike").when(Power(">=", 60, 6))
  single.use("Blood Boil")

  local multi = Rotation()
  multi.use("Marrowrend").when(Not(Buffed("Bone Shield")))
  multi.use("Death Strike")
  multi.use("Blooddrinker")
  multi.use("Blood Boil").when(Not(Debuffed("Blood Plague")))
  multi.use("Marrowrend").when(Charges("<=", 6, "Bone Shield"))
  multi.use("Death and Decay")
  multi.use("Heart Strike").when(Power(">=", 60, 6))
  multi.use("Blood Boil")

  return {
    talents = function() return talents end,
    single = function() return single.get() end,
    multi = function() return multi.get() end
  }

end
