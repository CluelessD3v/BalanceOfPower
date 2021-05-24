local CustomInstance = {}

function CustomInstance.new(aClassName, aParent, aFieldMap)
    local newInstance = Instance.new(aClassName)

    for property, value in pairs (aFieldMap.Properties) do 
        newInstance[property] = value
    end

 
    for attribute, value in pairs(aFieldMap.Attributes) do
        newInstance:SetAttribute(attribute, value)
    end

    newInstance.Parent = aParent
    return newInstance
end


return CustomInstance