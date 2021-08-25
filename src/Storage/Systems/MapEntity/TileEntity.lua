local ReplicatedStorage = game:GetService('ReplicatedStorage')
local CollectionService = game:GetService('CollectionService')

local MapDataToInstance = require(ReplicatedStorage.Utilities.MapDataToInstance)
-------------------- Constructor --------------------

local Tile = {} 
Tile.__index = Tile

function Tile.new(anInstance: PVInstance)
    local self = setmetatable({}, Tile)
    assert(anInstance ~= nil, "Error, cannot must pass an instance!")
    self.GameObject = anInstance

    return self
end
    

-- private functions
local function RemoveMetadata(self)
    local oldTags = CollectionService:GetTags(self.GameObject)
    local oldAttributes = self.GameObject:GetAttributes()
    
    for attribute, _ in pairs(oldAttributes) do
        self.GameObject:SetAttribute(attribute, nil)
    end

    for _, tag in ipairs (oldTags) do
        CollectionService:RemoveTag(self.GameObject, tag)
    end
end


-------------------- Data setting Routines --------------------

-- Automatically sets metadata to tile from the terrain types table
function Tile:InitMetadata(theNoiseResult: number, theTerrainTypesTable: table)
    CollectionService:AddTag(self.GameObject, "Tile")

    for i = 1, #theTerrainTypesTable -1 do
        local currentKey = theTerrainTypesTable[i] -- current value in the list
        local nextKey = theTerrainTypesTable[i + 1]   -- next value in the list
        
        -- this is an If statement to check if we are in range 
        if theNoiseResult >= currentKey.ExtraData.Threshold and theNoiseResult <= nextKey.ExtraData.Threshold then
            currentKey.ExtraData.Limit = currentKey.ExtraData.Limit or 2e9 --> 
            MapDataToInstance(self.GameObject, currentKey)
        end
    end


end

--  OverWrites existing data!
function Tile:SetMetadata(newTerrainDataTable)
    newTerrainDataTable.Attributes = newTerrainDataTable.Attributes or {}
    newTerrainDataTable.Properties = newTerrainDataTable.Properties or {} 
    newTerrainDataTable.Tags = newTerrainDataTable.Tags or {}  
    
    RemoveMetadata(self)
    
    -- reseting tile tag, we erased it by calling RemoveData ┐(￣ヘ￣)┌	
    CollectionService:AddTag(self.GameObject, "Tile")
    MapDataToInstance(self.GameObject, newTerrainDataTable)
end

-- Updates existing data w/o removing existing data
function Tile:UpdateMetadata(newTerrainDataTable)
    newTerrainDataTable.Attributes = newTerrainDataTable.Attributes or {}
    newTerrainDataTable.Properties = newTerrainDataTable.Properties or {} 
    newTerrainDataTable.Tags = newTerrainDataTable.Tags or {}  

    -- Updating Data tile tag
    CollectionService:AddTag(self.GameObject, "Tile") --> idk if this is necessary ._. //TODO FIXCON4 test if is necessary to update tile tag
    MapDataToInstance(self.GameObject, newTerrainDataTable)
end


-------------------- Positioning relative to tile Routines --------------------


function Tile:InstanceAcrossTile(taggedpropList: table, aChance: integer, hasRandomOrientation: boolean)
    for x = 1, self.GameObject.Size.X do
        for z = 1, self.GameObject.Size.Z do
            local chance = math.floor(Random.new():NextNumber(1, 100))
            if chance <= aChance then

                local prop = taggedpropList[math.random(1, #taggedpropList)]:Clone()
                
                prop.Size = Vector3.new(self.GameObject.Size.X * .1, self.GameObject.Size.Y * .2 , self.GameObject.Size.Z * .1 )
                                    
                local xOffset = x * prop.Size.X - self.GameObject.Size.X/2
                local zOffset =  z * prop.Size.Z  - self.GameObject.Size.Z/2
                local yOffset =  self.GameObject.Size.Y/2 + prop.Size.Y/2 
                prop.Position = self.Position + Vector3.new(xOffset, yOffset, zOffset)
                
                if hasRandomOrientation then
                    prop.Orientation = Vector3.new(0, math.random(0, 360),0)
                end

                prop.Parent = self.ga
             end
         end
     end
end

-- function Tile.InstanceToOriginOffseted(: table, taggedpropList: table, aChance: integer, hasRandomOrientation: boolean)
--     for _, tile in ipairs(taggedTilesList) do

--         local chance = Random.new():NextNumber(0, 1)
--         if chance <= aChance then
--             local prop = taggedpropList[math.random(1, #taggedpropList)]:Clone()
            
--             if hasRandomOrientation then
--                 prop.Orientation = Vector3.new(0, math.random(0, 360),0)
--             end

--             prop.Size = Vector3.new(tile.Size.X, prop.Size.Y, tile.Size.Z)
            
--             local yOffset =  tile.Size.Y/2 + prop.Size.Y/2
--             prop.Position = tile.Position + Vector3.new(0, yOffset, 0)
--             prop.Parent = tile
--         end
--     end
-- end

-- Positions an instance on top with the tile "FLUSH"
function Tile:InstanceToOriginOffseted(aProp: Instance, hasRandomOrientation: boolean)

    local prop = aProp:Clone()

    -- Taking into account wheter the model is part or a model.

    if  prop:IsA("Model") then
        local yOffset =  self.GameObject.Size.Y/2 + prop:GetExtentsSize().Y/2-.5 
        prop:PivotTo(CFrame.new(self.GameObject.Position + Vector3.new(0, yOffset, 0 )))
    
        if hasRandomOrientation then
            local randi = math.random(0, 360)
            prop:PivotTo(prop:GetPivot() * CFrame.Angles(0, randi, 0)) 
        end
    else
        local yOffset =  self.GameObject.Size.Y/2 + prop.Size.Y/2
        prop.Position = self.GameObject.Position + Vector3.new(0, yOffset, 0)
        
        if hasRandomOrientation then
            prop.Orientation = Vector3.new(0, math.random(0, 360),0)
        end        
    end
    
    prop.Parent = self.GameObject  

end

return Tile