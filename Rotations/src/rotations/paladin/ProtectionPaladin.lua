local Buffed = PhineRotations.Buffed
local Not = PhineRotations.Not
local Rotation = PhineRotations.Rotation

function PhineRotations:ProtectionPaladin()
  local talents = {}

  local single = Rotation()
  single.use("Consecration").when(Not(Buffed("Consecration")))
  single.use("Judgment")
  single.use("Avenger's Shield")
  single.use("Hammer of the Righteous")
  single.use("Consecration")

  local multi = Rotation()
  multi.use("Consecration").when(Not(Buffed("Consecration")))
  multi.use("Judgment")
  multi.use("Avenger's Shield")
  multi.use("Hammer of the Righteous")
  multi.use("Consecration")

  return {
    talents = function() return talents end,
    single = function() return single.get() end,
    multi = function() return multi.get() end
  }
end
