local CollectionService = game:GetService('CollectionService')
local CustomInstance = {}

function CustomInstance.new(aClassName, aFieldMap)
    aFieldMap = aFieldMap or {
        Properties = {},
        Attributes = {},
        Tags = {}

    }

    local properties = aFieldMap.Properties or {}
    local Attributes = aFieldMap.Attributes or {}
    local tags = aFieldMap.Tags or {}

    local newInstance = Instance.new(aClassName)

    for property, value in pairs (properties) do 
        newInstance[property] = value
    end

 
    for attribute, value in pairs(Attributes) do
        newInstance:SetAttribute(attribute, value)
    end

    for _, tag in pairs(tags) do
        CollectionService:AddTag(newInstance, tag)
    end

    return newInstance
end


return CustomInstance