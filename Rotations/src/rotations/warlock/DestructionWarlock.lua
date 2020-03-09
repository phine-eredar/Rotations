local Debuffed = PhineRotations.Debuffed
local Not = PhineRotations.Not
local Power = PhineRotations.Power
local Rotation = PhineRotations.Rotation

function PhineRotations:DestructionWarlock()
  local talents = {}

  local single = Rotation();
  single.use("Immolate").when(Not(Debuffed("Immolate")))
  single.use("Chaos Bolt").when(Power(">=", 5, 7))
  single.use("Conflagrate")
  single.use("Incinerate")

  local multi = Rotation()

  return {
     talents = function() return talents end,
     single = function() return single.get() end,
     multi = function() return multi.get() end
   }
end
