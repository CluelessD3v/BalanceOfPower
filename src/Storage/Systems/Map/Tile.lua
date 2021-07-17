local ReplicatedStorage = game:GetService('ReplicatedStorage')
local CustomInstance = require(ReplicatedStorage.Utilities.CustomInstance)
local CollectionService = game:GetService('CollectionService')


local Tile = {} 
Tile.__index = Tile

function Tile.new()
    local self = setmetatable({}, Tile)
    self.GameObject = Instance.new("Part")
    self.GameObject.Anchored = true
    
    self.GameObject:SetAttribute("TerrainColor", BrickColor.new("Black"))
    self.GameObject:SetAttribute("ElevationOffset", 1)
    self.GameObject:SetAttribute("ResourceAmmount", 0)
    self.GameObject:SetAttribute("HasResource", false)

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

function Tile:SetMetadata(theNoiseResult: number, theTerrainTypesTable: table)
    
    -- offset the index - 1 to get the current terrain and the next one
    for i = 1, #theTerrainTypesTable -1 do
        local this = theTerrainTypesTable[i] -- current value in the list
        local next = theTerrainTypesTable[i + 1]   -- next value in the list

        -- this is an If statement to check if we are in range

        if theNoiseResult >= this.TerrainThreshold and theNoiseResult <= next.TerrainThreshold then


            CollectionService:AddTag(self.GameObject, this.TerrainTag)
            CollectionService:AddTag(self.GameObject, this.FeatureTag)

            self.GameObject:SetAttribute("TerrainColor", this.TerrainColor)
            self.GameObject:SetAttribute("ElevationOffset", this.ElevationOffset)
            self.GameObject:SetAttribute("TerrainThreshold", this.TerrainThreshold)
        end
    end
end




return Tile