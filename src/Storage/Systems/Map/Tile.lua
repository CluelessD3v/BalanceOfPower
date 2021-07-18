local ReplicatedStorage = game:GetService('ReplicatedStorage')
local CustomInstance = require(ReplicatedStorage.Utilities.CustomInstance)
local CollectionService = game:GetService('CollectionService')


local Tile = {} 
Tile.__index = Tile

function Tile.new()
    local self = setmetatable({}, Tile)
    self.GameObject = Instance.new("Part")
    self.GameObject.Anchored = true
    
    CollectionService:AddTag(self.GameObject, "Tile")

        
    return self
end
    


-- Public Methods
--//TODO Check about Listenning for attribute changes

-- Automatically sets metadata to tile from the terrain types table
function Tile:InitMetadata(theNoiseResult: number, theTerrainTypesTable: table)
    for i = 1, #theTerrainTypesTable -1 do
        local this = theTerrainTypesTable[i] -- current value in the list
        local next = theTerrainTypesTable[i + 1]   -- next value in the list
        
        -- this is an If statement to check if we are in rangeBTW
        if theNoiseResult >= this.Attributes.TerrainThreshold and theNoiseResult <= next.Attributes.TerrainThreshold then
            
            for property, value in pairs(this.Properties) do
                self.GameObject[property] = value
            end

            for attribute, value in pairs(this.Attributes) do
                self.GameObject:SetAttribute(attribute, value)
            end

            for key, tag in pairs (this.Tags) do
                CollectionService:AddTag(self.GameObject, tag)
            end

            for index, tag in ipairs (this.Descriptors) do
                CollectionService:AddTag(self.GameObject, tag)
            end  
        end
    end


end

--  OverWrites existing data!
function Tile:SetMetadata()
    local oldTags = CollectionService:GetTags(self.GameObject)
    -- removing old tags
    for _, tag in ipairs (oldTags) do
        CollectionService:RemoveTag(self.GameObject, tag)
    end
end

return Tile