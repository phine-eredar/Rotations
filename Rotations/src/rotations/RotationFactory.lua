function PhineRotations:RotationFactory(wow)
  return {
    newRotation = function()

      local rotation

      local activeSpecGroup = GetActiveSpecGroup()
      local specId = GetSpecializationInfo(activeSpecGroup)

      if (specId == 71) then
        rotation = PhineRotations:FuryWarrior()
      else print("Unsupported specialization: " .. specId)
      end

      return rotation

    end
  }
end
