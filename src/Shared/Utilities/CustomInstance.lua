local CustomInstance = {}

function CustomInstance.new(aClassName, aParent, aFieldMap)
    aFieldMap = aFieldMap or {
        Properties = {},
        Attributes = {}

    }

    local properties = aFieldMap.Properties or {}
    local Attributes = aFieldMap.Attributes or {}

    local newInstance = Instance.new(aClassName)

    for property, value in pairs (properties) do 
        newInstance[property] = value
    end

 
    for attribute, value in pairs(Attributes) do
        newInstance:SetAttribute(attribute, value)
    end

    newInstance.Parent = aParent
    return newInstance
end


return CustomInstance