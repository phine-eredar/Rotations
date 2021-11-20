local Buffed = PhineRotations.Buffed
local Charges = PhineRotations.Charges
local Debuffed = PhineRotations.Debuffed
local Not = PhineRotations.Not
local Rotation = PhineRotations.Rotation

function PhineRotations:GuardianDruid()
  local talents = {}

  local single = Rotation()
  single.use("Moonfire").when(Not(Debuffed("Moonfire")))
  single.use("Thrash").when(Charges("<", 3, nil, 'Thrash'))
  single.use("Mangle")
  single.use("Thrash")
  single.use("Moonfire").when(Buffed("Galactic Guardian"))
  single.use("Maul")
  single.use("Swipe")

  local multi = Rotation()
  multi.use("Moonfire").when(Not(Debuffed("Moonfire")))
  multi.use("Thrash")
  multi.use("Mangle")
  multi.use("Moonfire").when(Buffed("Galactic Guardian"))
  multi.use("Maul")
  multi.use("Swipe")

  return {
    talents = function() return talents end,
    single = function() return single.get() end,
    multi = function() return multi.get() end
  }
end
