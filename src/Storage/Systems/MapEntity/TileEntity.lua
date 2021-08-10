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


-------------------- Data setting Routines --------------------

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


-------------------- Positioning relative to tile Routines --------------------
--[[
    this places N number of assets allong the tile
    
    x   o   x -- representation of a tile, each X is an asset
    o   x   o -- specially good for trees and pebbles
    x   x   o
    o   x   x

    NOTE: this function will respect the boundaries of the tile INDEPENDENTLY of the asset size.
]]--

-->//TODO FIXCON3 probably delete this method due to performance reasons and replace with single models
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

                prop.Parent = self.GameObject
             end
         end
     end
end
--[[ 
    tHIS PLACES AN ASSET EXACTLY IN THE MIDLE OF TILE + Y offset 
            I
            I            
            I-- TREE ASSET EXAMPLE
    ----------------------
    ----------------------
                specially good for grass and big rocks
--]]

function Tile.InstanceToOrigin(taggedTilesList: table, taggedpropList: table, aChance: integer, hasRandomOrientation: boolean)
    for _, tile in ipairs(taggedTilesList) do

        local chance = Random.new():NextNumber(0, 1)
        if chance <= aChance then
            local prop = taggedpropList[math.random(1, #taggedpropList)]:Clone()
            
            if hasRandomOrientation then
                prop.Orientation = Vector3.new(0, math.random(0, 360),0)
            end

            prop.Size = Vector3.new(tile.Size.X, prop.Size.Y, tile.Size.Z)
            
            local yOffset =  tile.Size.Y/2 + prop.Size.Y/2
            prop.Position = tile.Position + Vector3.new(0, yOffset, 0)
            prop.Parent = tile
        end
    end
end



return Tile