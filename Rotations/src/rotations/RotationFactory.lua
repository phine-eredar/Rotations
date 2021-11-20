function PhineRotations:RotationFactory(wow)
  local CLASS_NAMES = {
    [1] = "Warrior",
    [2] = "Paladin",
    [3] = "Hunter",
    [4] = "Rogue",
    [5] = "Priest",
    [6] = "DeathKnight",
    [7] = "Shaman",
    [8] = "Mage",
    [9] = "Warlock",
    [10] = "Monk",
    [11] = "Druid",
    [12] = "DemonHunter"
  }

  return {
      newRotation = function()
        local specId = wow.GetSpecialization()
        if (not specId) then return end
        local _, specNameWithSpaces = wow.GetSpecializationInfo(specId)
        if (not specNameWithSpaces) then return end
        local specName = string.gsub(specNameWithSpaces, " ", "")
        local _, _, classId = wow.UnitClass("player")
        local className = CLASS_NAMES[classId]
        if (not PhineRotations[specName .. className]) then return end
        return PhineRotations[specName .. className]()
      end
  }
end
