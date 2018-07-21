function PhineRotations.Not(condition)
  condition.active = false
  return condition
end

function PhineRotations.Buffed(name)
  return { type = "buff", name = name, active = true }
end

function PhineRotations.And(cond1, cond2)
  return { type = "and", children = { cond1, cond2 } }
end

function PhineRotations.Or(cond1, cond2)
  return { type = "or", children = { cond1, cond2 } }
end

function PhineRotations.Power(operator, value)
  return { type = "power", operator = operator, value = value }
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

  this.whenAll = function(cond1, cond2)
    return this.when(PhineRotations.And(cond1, cond2))
  end

  this.whenAny = function(cond1, cond2)
    return this.when(PhineRotations.Or(cond1, cond2))
  end

  this.when = function(condition)
    table.insert(rotation[#rotation].conditions, condition)
    return this
  end

  this.get = function() return rotation end

  return this
end