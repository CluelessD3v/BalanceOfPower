local ServerStorage = game:GetService("ServerStorage")
local ResourceTypesTables = require(ServerStorage.Components.ResourcestTypesTables)

local ResourceEntity = {} 
ResourceEntity.__index = ResourceEntity

function ResourceEntity.new(aTile:BasePart, aProp)
    local self = setmetatable({}, ResourceEntity)

    
    
    return self
end

return ResourceEntity