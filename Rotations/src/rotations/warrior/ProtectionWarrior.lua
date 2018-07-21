local Buffed = PhineRotations.Buffed
local Rotation = PhineRotations.Rotation

function PhineRotations:ProtectionWarrior()
  local talents = {}

  local single = Rotation()
  single.use("Shield Slam")
  single.use("Thunder Clap")
  single.use("Revenge").when(Buffed("Revenge!"))
  single.use("Devastate")

  local multi = Rotation()
  multi.use("Shield Slam")
  multi.use("Thunder Clap")
  multi.use("Revenge").when(Buffed("Revenge!"))
  multi.use("Devastate")

  return {
    talents = function() return talents end,
    single = function() return single.get() end,
    multi = function() return multi.get() end
  }
end
