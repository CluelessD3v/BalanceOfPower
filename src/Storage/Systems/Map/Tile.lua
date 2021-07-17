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
        
    -- Attribute change listeners, automatically uptades tile pertinent tile properties on Attribute changed
    
    local tile: BasePart = self.GameObject
    tile:GetAttributeChangedSignal("TerrainColor"):Connect(function()
        tile.BrickColor = tile:GetAttribute("TerrainColor")
    end)

    tile:GetAttributeChangedSignal("ElevationOffset"):Connect(function()
        tile.Position = Vector3.new(tile.Position.X, tile:GetAttribute("ElevationOffset"),tile.Position.Z) -- overwrite tile pos
    end)

    return self
end
    


-- Public Methods

-- Automatically sets metadata to tile from the terrain types table
function Tile:SetMetadata(theNoiseResult: number, theTerrainTypesTable: table)
    for i = 1, #theTerrainTypesTable -1 do
        local this = theTerrainTypesTable[i] -- current value in the list
        local next = theTerrainTypesTable[i + 1]   -- next value in the list
        
        -- this is an If statement to check if we are in range
        if theNoiseResult >= this.Attributes.TerrainThreshold and theNoiseResult <= next.Attributes.TerrainThreshold then
            
            for attribute, value in pairs(this.Attributes) do
                self.GameObject:SetAttribute(attribute, value)
            end

            for _, tag in pairs (this.Tags) do
                CollectionService:AddTag(self.GameObject, tag)
            end

            for _, tag in ipairs (this.Descriptors) do
                CollectionService:AddTag(self.GameObject, tag)
            end  
        end
    end

end

return Tile