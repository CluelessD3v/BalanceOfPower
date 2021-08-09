local ReplicatedStorage = game:GetService('ReplicatedStorage')
local CollectionService = game:GetService('CollectionService')

local MapDataToInstance = require(ReplicatedStorage.Utilities.MapDataToInstance)
-------------------- Constructor --------------------

local Tile = {} 
Tile.__index = Tile

function Tile.new()
    local self = setmetatable({}, Tile)
    self.GameObject = Instance.new("Part")
    
    
    CollectionService:AddTag(self.GameObject, "Tile")

        
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


-------------------- Public Routines --------------------

-- Automatically sets metadata to tile from the terrain types table
function Tile:InitMetadata(theNoiseResult: number, theTerrainTypesTable: table)


    for i = 1, #theTerrainTypesTable -1 do
        local currentKey = theTerrainTypesTable[i] -- current value in the list
        local nextKey = theTerrainTypesTable[i + 1]   -- next value in the list
        
        -- this is an If statement to check if we are in range 
        if theNoiseResult >= currentKey.Threshold and theNoiseResult <= nextKey.Threshold then
            currentKey.Limit = currentKey.Limit or 2e9 --> 
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
function Tile:UpdateMetaData(newTerrainDataTable)
    newTerrainDataTable.Attributes = newTerrainDataTable.Attributes or {}
    newTerrainDataTable.Properties = newTerrainDataTable.Properties or {} 
    newTerrainDataTable.Tags = newTerrainDataTable.Tags or {}  

    -- Updating Data tile tag
    CollectionService:AddTag(self.GameObject, "Tile") --> idk if this is necessary ._. //TODO FIXCON4 test if is necessary to update tile tag
    MapDataToInstance(self.GameObject, newTerrainDataTable)
end


return Tile