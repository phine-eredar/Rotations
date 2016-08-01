function PhineRotations:NextAbilityProvider(wow)

  local ABILITY_IDS = {
    ["Void Bolt"] = 205448
  }

  local evaluateOperation = function(value, condition)

    local met = false

    if condition.operator == "<" then
      met = value < condition.value
    elseif condition.operator == "<=" then
      met = value <= condition.value
    elseif condition.operator == "==" then
      met = value == condition.value
    elseif condition.operator == ">=" then
      met = value >= condition.value
    elseif condition.operator == ">" then
      met = value > condition.value
    else print("Unsupported operator: " .. condition.operator)
    end

    return met

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

      local buffed = wow.UnitBuff("player", condition.name) == condition.name

      if condition.active then
        met = buffed
      else
        met = not buffed
      end

    elseif condition.type == "charges" then

      local charges = wow.GetSpellCharges(ability)

      met = evaluateOperation(charges, condition)

    elseif condition.type == "debuff" then

      local debuffed = false

      for i=1, 40 do
        local name, _, _, _, _, _, _ , unitCaster = UnitDebuff("target", i);
        if unitCaster == "player" and name == condition.name then
          local start, duration = wow.GetSpellCooldown(ABILITY_IDS[ability] or ability)
          if start + duration - wow.GetTime() > 5 then
            debuffed = true
          end
        end
      end

      if condition.active then
        met = debuffed
      else
        met = not debuffed
      end

    elseif condition.type == "or" then

      for i, child in ipairs(condition.children) do
        met = met or evaluateCondition(child, talents, ability)
      end

    elseif condition.type == "power" then

      local power = wow.UnitPower("player", condition.powerType or 0)

      met = evaluateOperation(power, condition)

    elseif condition.type == "talent" then

      local talent = talents[condition.name]
      local _, _, _, selected = wow.GetTalentInfo(talent.tier, talent.column, 1)

      if (condition.active) then
        met = selected
      else
        met = not selected
      end

    else print("Unsupported condition type: " .. condition.type)

    end

    return met

  end

  local evaluateRule = function(rule, talents)

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
