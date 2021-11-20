function PhineRotations.And(...)
  return { type = "and", children = { ... } }
end

function PhineRotations.Buffed(name)
  return { type = "buff", name = name, active = true }
end

function PhineRotations.Charges(operator, value, buff, debuff)
  return { type = "charges", operator = operator, value = value, buff = buff, debuff = debuff }
end

function PhineRotations.Combo(operator, value)
  return { type = "combo", operator = operator, value = value }
end

function PhineRotations.Cooldown(name, operator, value)
  return { type = "cooldown", name = name, operator = operator, value = value }
end

function PhineRotations.Debuffed(name, buffer)
  return { type = "debuff", name = name, active = true, buffer = buffer or 0 }
end

function PhineRotations.Name(unit, name)
  return { type = "name", unit = unit, name = name }
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

function PhineRotations.Totem(buffer, index)
  return { type = "totem", buffer = buffer or 0, index = index or 1 }
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

PhineRotations.POWER = {
  MANA = 0,
  RAGE = 1,
  FOCUS = 2,
  ENERGY = 3,
  COMBO_POINTS = 4,
  RUNES = 5,
  RUNIC_POWER = 6,
  SOUL_SHARDS = 7,
  LUNAR_POWER = 8,
  HOLY_POWER = 9,
  ALTERNATE_POWER = 10,
  MAELSTROM = 11,
  CHI = 12,
  INSANITY = 13,
  ARCANE_CHARGES = 16,
  FURY = 17,
  PAIN = 18
}
