local Buffed = PhineRotations.Buffed
local Not = PhineRotations.Not
local Power = PhineRotations.Power
local Rotation = PhineRotations.Rotation

function PhineRotations:EnhancementShaman()
  local talents = {}

  local single = Rotation()
  single.use("Lightning Shield").when(Not(Buffed("Lightning Shield")))
  single.use("Flametongue").when(Not(Buffed("Flametongue")))
  single.use("Stormstrike")
  single.use("Flametongue")
  single.use("Sundering")
  single.use("Rockbiter").when(Power("<", 70))
  single.use("Lava Lash").when(Power(">", 40))
  single.use("Rockbiter")

  local multi = Rotation()
  multi.use("Lightning Shield").when(Not(Buffed("Lightning Shield")))
  multi.use("Crash Lightning")
  multi.use("Flametongue").when(Not(Buffed("Flametongue")))
  multi.use("Stormstrike")
  multi.use("Flametongue")
  multi.use("Sundering")
  multi.use("Rockbiter").when(Power("<", 70))
  multi.use("Lava Lash").when(Power(">", 40))
  multi.use("Rockbiter")

  return {
    talents = function() return talents end,
    single = function() return single.get() end,
    multi = function() return multi.get() end
  }
end
