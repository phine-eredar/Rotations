local Buffed = PhineRotations.Buffed
local Not = PhineRotations.Not
local Power = PhineRotations.Power
local Rotation = PhineRotations.Rotation

function PhineRotations:EnhancementShaman()
  local talents = {}

  local single = Rotation()
  single.use("Lightning Shield").when(Not(Buffed("Lightning Shield")))
  single.use("Sundering")
  single.use("Stormstrike")
  single.use("Flametongue")
  single.use("Lava Lash").when(Power(">=", 50))
  single.use("Rockbiter")

  local multi = Rotation()
  multi.use("Lightning Shield").when(Not(Buffed("Lightning Shield")))
  multi.use("Sundering")
  multi.use("Crash Lightning")
  multi.use("Stormstrike")
  multi.use("Flametongue")
  multi.use("Lava Lash").when(Power(">=", 50))
  multi.use("Rockbiter")

  return {
    talents = function() return talents end,
    single = function() return single.get() end,
    multi = function() return multi.get() end
  }
end
