--[[
    This module assists in the easy mapping of metadata organic proper to an instance
]]---

local CollectionService = game:GetService('CollectionService')

return function (anInstance: PVInstance, aFieldMap: table)
    aFieldMap = aFieldMap or {
        Properties = {},
        Attributes = {},
        Tags = {},
        ExtraData = {}
    }

    -- Default to empty table if there is no field
    local properties = aFieldMap.Properties or {}
    local Attributes = aFieldMap.Attributes or {}
    local tags = aFieldMap.Tags or {}
    

    for property, value in pairs (properties) do 
        anInstance[property] = value
    end

 
    for attribute, value in pairs(Attributes) do
        anInstance:SetAttribute(attribute, value)
    end

    for _, tag in pairs(tags) do
        CollectionService:AddTag(anInstance, tag)
    end

    return anInstance
end
