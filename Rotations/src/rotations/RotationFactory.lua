function PhineRotations:RotationFactory(wow)

  local specializationNames = {
    [70] = 'RetributionPaladin',
    [72] = 'FuryWarrior',
    [263] = 'EnhancementShaman'
  }

  return {

      newRotation = function()

        local specialization = GetSpecialization()
        local specializationId = GetSpecializationInfo(specialization)

        local specializationName = specializationNames[specializationId]

        if (not specializationName) then return end

        return PhineRotations[specializationName]()

      end

  }

end
