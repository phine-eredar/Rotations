local Buffed = PhineRotations.Buffed
local Debuffed = PhineRotations.Debuffed
local Rotation = PhineRotations.Rotation

function PhineRotations:FrostMage()
  local talents = {}

  local single = Rotation()
  single.use("Frozen Orb")
  single.use("Flurry").when(Buffed("Brain Freeze"))
  single.use("Ice Lance").whenAny(Buffed("Fingers of Frost"), Debuffed("Winter's Chill"))
  single.use("Frostbolt")

  local multi = Rotation()
  multi.use("Frozen Orb")
  multi.use("Flurry").when(Buffed("Brain Freeze"))
  multi.use("Ice Lance").whenAny(Buffed("Fingers of Frost"), Debuffed("Winter's Chill"))
  multi.use("Blizzard")

  return {
    talents = function() return talents end,
    single = function() return single.get() end,
    multi = function() return multi.get() end
  }
end
