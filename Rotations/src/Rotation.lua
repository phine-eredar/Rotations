function PhineRotations.And(...)
  return { type = "and", children = { ... } }
end

function PhineRotations.Buffed(name)
  return { type = "buff", name = name, active = true }
end

function PhineRotations.Charges(operator, value, buff)
  return { type = "charges", operator = operator, value = value, buff = buff }
end

function PhineRotations.Combo(operator, value)
  return { type = "combo", operator = operator, value = value }
end

function PhineRotations.Debuffed(name, buffer)
  return { type = "debuff", name = name, active = true, buffer = buffer or 0 }
end

function PhineRotations.Not(condition)
  condition.active = false
  return condition
end

function PhineRotations.Or(...)
  return { type = "or", children = { ... } }
end

function PhineRotations.Power(operator, value, powerType)
  return { type = "power", operator = operator, value = value, powerType = powerType }
end

function PhineRotations.Talented(name)
  return { type = "talent", name = name, active = true }
end

function PhineRotations.Rotation(rotation)
  rotation = rotation or {}

  local this = {}

  this.use = function(ability)
    table.insert(rotation, { conditions = {}, ability = ability })
    return this
  end

  this.whenAll = function(...)
    return this.when(PhineRotations.And(...))
  end

  this.whenAny = function(...)
    return this.when(PhineRotations.Or(...))
  end

  this.when = function(condition)
    table.insert(rotation[#rotation].conditions, condition)
    return this
  end

  this.get = function() return rotation end

  return this
end