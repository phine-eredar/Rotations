function PhineRotations:NextAbilityProvider(wow)
  local ABILITY_IDS = {
    ["Void Bolt"] = 205448
  }

  local DISTANCE_INDICES = {
    Inspect = 1,
    Trade = 2,
    Duel = 3,
    Follow = 4
  }

  local evaluateOperation = function(value, condition)
    local met = false

    value = value or 0;

    if not condition.operator then
      wow.print("Missing condition operator: " .. condition.type)
    elseif condition.operator == "<" then
      met = value < condition.value
    elseif condition.operator == "<=" then
      met = value <= condition.value
    elseif condition.operator == "==" then
      met = value == condition.value
    elseif condition.operator == ">=" then
      met = value >= condition.value
    elseif condition.operator == ">" then
      met = value > condition.value
    else wow.print("Unsupported operator: " .. condition.operator)
    end

    return met
  end

  local findBuff = function(name)
    for i = 1, 40 do
      if wow.UnitBuff("player", i) == name then return wow.UnitBuff("player", i); end
    end
  end

  local findDebuff = function(condition)
    local now = wow.GetTime()
    local buffer = condition.buffer or 0
    for i = 1, 40 do
      local name, _, _, _, _, exp = wow.UnitDebuff("target", i, "PLAYER")
      if name == condition.name and exp - now > buffer then return wow.UnitDebuff("target", i, "PLAYER") end
    end
    return false
  end

  local evaluateCondition
  evaluateCondition = function(condition, talents, ability)
    local met = false

    if condition.type == "and" then
      met = true
      for i, child in ipairs(condition.children) do
        met = met and evaluateCondition(child, talents, ability)
      end
    elseif condition.type == "buff" then
      local buffed = findBuff(condition.name)
      if condition.active then
        met = buffed
      else
        met = not buffed
      end
    elseif condition.type == "cooldown" then
      local start, duration = wow.GetSpellCooldown(condition.name)
      local remaining = 0
      if duration > 0 then
        remaining = duration - wow.GetTime() + start
      end
      met = evaluateOperation(remaining, condition)
    elseif condition.type == "bufftime" then
      local name, _, _, _, _, _, expirationTime = findBuff(condition.name)
      if expirationTime ~= nil then
        met = name == condition.name and evaluateOperation(expirationTime - wow.GetTime(), condition)
      end
    elseif condition.type == "charges" then
      local charges = 0
      if (condition.buff ~= nil) then
        local _, _, count = findBuff(condition.buff)
        charges = count or 0
      elseif (condition.debuff ~= nil) then
        local _, _, count = findDebuff({ name = condition.debuff })
        charges = count or 0
      else
        charges = wow.GetSpellCharges(condition.ability or ability)
      end
      met = evaluateOperation(charges, condition)
    elseif condition.type == "combo" then
      local comboPoints = wow.GetComboPoints("player", "target")
      met = evaluateOperation(comboPoints, condition)
    elseif condition.type == "debuff" then
      local debuffed = findDebuff(condition)
      if condition.active then met = debuffed else met = not debuffed end
    elseif condition.type == "distance" then
      local distanceIndex = DISTANCE_INDICES[condition.distance]
      met = wow.CheckInteractDistance("target", distanceIndex)
    elseif condition.type == "health" then
      local unit = condition.unit or "target"
      local health = wow.UnitHealth(unit)
      local healthMax = wow.UnitHealthMax(unit)
      met = evaluateOperation(100 * health / healthMax, condition)
    elseif condition.type == "name" then
      met = wow.UnitFullName(condition.unit) == condition.name
    elseif condition.type == "or" then
      for i, child in ipairs(condition.children) do
        met = met or evaluateCondition(child, talents, ability)
      end
    elseif condition.type == "power" then
      local power = wow.UnitPower("player", condition.powerType or 0)
      met = evaluateOperation(power, condition)
    elseif condition.type == "runes" then
      local runes = 0
      for i = 1, 6 do
        local _, _, runeReady = wow.GetRuneCooldown(i)
        if runeReady then
          runes = runes + 1
        end
      end
      met = evaluateOperation(runes, condition)
    elseif condition.type == "talent" then
      local talent = talents[condition.name]
      local _, _, _, selected = wow.GetTalentInfo(talent.tier, talent.column, 1)
      if (condition.active) then
        met = selected
      else
        met = not selected
      end
    elseif condition.type == "totem" then
      local _, _, start, duration = wow.GetTotemInfo(condition.index)
      met = start + duration - wow.GetTime() < condition.buffer
    else wow.print("Unsupported condition type: " .. condition.type)
    end

    return met
  end

  local evaluateRule = function(rule, talents)
    local castingName, _, _, _, _, _, _, _, castingSpellId = wow.UnitCastingInfo("player")
    local currentCharges = wow.GetSpellCharges(castingSpellId)
    if castingName == rule.ability and currentCharges == 1 then
      return
    end

    local usable = wow.IsUsableSpell(rule.ability)
    if not usable then
      return
    end

    local charges = wow.GetSpellCharges(rule.ability)
    if charges == 0 then
      return
    end

    local ability = ABILITY_IDS[rule.ability] or rule.ability
    local start, duration = wow.GetSpellCooldown(ability)
    local ready = start + duration - wow.GetTime() <= 1.5
    if not ready then
      return
    end

    if rule.conditions then
      for i, condition in ipairs(rule.conditions) do
        if not evaluateCondition(condition, talents, rule.ability) then
          return
        end
      end
    end

    return rule.ability
  end

  return {
    next = function(rotation, talents)
      for i, rule in ipairs(rotation) do
        local ability = evaluateRule(rule, talents)
        if ability ~= nil then
          return ability
        end
      end
      return ""
    end
  }
end
