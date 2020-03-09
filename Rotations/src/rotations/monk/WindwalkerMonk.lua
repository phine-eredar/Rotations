local Power = PhineRotations.Power
local Rotation = PhineRotations.Rotation

function PhineRotations:WindwalkerMonk()
  local talents = {}

  local single = Rotation()
  single.use("Fist of the White Tiger").whenAll(Power("<", 3, 12), Power(">=", 80, 3))
  single.use("Reverse Harm").when(Power("<", 4, 12))
  single.use("Tiger Palm").whenAll(Power("<", 4, 12), Power(">=", 80, 3))
  single.use("Whirling Dragon Punch")
  single.use("Rising Sun Kick")
  single.use("Fists of Fury")
  single.use("Fist of the White Tiger").when(Power("<", 3, 12))
  single.use("Blackout Kick")
  single.use("Tiger Palm")

  local multi = Rotation()
  multi.use("Whirling Dragon Punch")
  multi.use("Fists of Fury")
  multi.use("Rising Sun Kick")
  multi.use("Spinning Crane Kick")
  multi.use("Rising Sun Kick")
  multi.use("Blackout Kick")
  multi.use("Fist of the White Tiger")
  multi.use("Tiger Palm")

  return {
    talents = function() return talents end,
    single = function() return single.get() end,
    multi = function() return multi.get() end
  }
end
