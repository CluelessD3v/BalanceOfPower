local CollectionService = game:GetService('CollectionService')
local RunService = game:GetService('RunService')




local BuildingEntity = {} 
BuildingEntity.__index = BuildingEntity

function BuildingEntity.new(anInstance)
    local self = setmetatable({}, BuildingEntity)
    
    self.GameObject = anInstance
end


return BuildingEntity


