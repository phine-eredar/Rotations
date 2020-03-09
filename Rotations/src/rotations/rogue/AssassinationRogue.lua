local Combo = PhineRotations.Combo
local Debuffed = PhineRotations.Debuffed
local Not = PhineRotations.Not
local Rotation = PhineRotations.Rotation

function PhineRotations:AssassinationRogue()
  local talents = {}

  local single = Rotation();
  single.use("Rupture").whenAll(Combo(">=", 4), Not(Debuffed("Rupture")))
  single.use("Garrote").when(Not(Debuffed("Garrote")))
  single.use("Envenom").when(Combo(">=", 4))
  single.use("Mutilate");

  local multi = Rotation();
  multi.use("Rupture").whenAll(Combo(">=", 4), Not(Debuffed("Rupture")))
  multi.use("Garrote").when(Not(Debuffed("Garrote")))
  multi.use("Envenom").when(Combo(">=", 4))
  multi.use("Fan of Knives");

  return {
     talents = function() return talents end,
     single = function() return single.get() end,
     multi = function() return multi.get() end
   }
end
