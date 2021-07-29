local CollectionService = game:GetService('CollectionService')
local RunService = game:GetService('RunService')




local BuildingEntity = {} 
BuildingEntity.__index = BuildingEntity

function BuildingEntity.new()
    local self = setmetatable({}, BuildingEntity)
end


return BuildingEntity

