function PhineRotations:RotationFactory(wow)

  local classNames = {
    [71] = 'FuryWarrior',
    [262] = 'EnhancementShaman'
  }

  return {
  
    newRotation = function()

      local activeSpecGroup = GetActiveSpecGroup()
      local specId = GetSpecializationInfo(activeSpecGroup)
      
      local className = classNames[specId]
      
      if (not className) then return end
      
      return PhineRotations[className]()

    end
    
  }
  
end
