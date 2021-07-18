local CollectionService = game:GetService('CollectionService')

local PerlinNoise = require(script.PerlinNoise)
local FallOffMap = require(script.FallOffMap)
local Tile = require(script.Tile)
local GenerateProps = require(script.GenerateProps)

local Map = {} 
Map.__index = Map


-- Creates a new map object
function Map.new(theMapGenerationTable: table)    
    assert(theMapGenerationTable, "Map generation table no found!")

    
    local self = setmetatable({}, Map)

    --[[ 
        note: These Values are not random, they were selected so as to keep the map 
        as artifact free as possible from the filters and good looking
    --]]

    theMapGenerationTable.MapSize = theMapGenerationTable.MapSize or 100
    theMapGenerationTable.TileSize = theMapGenerationTable.TileSize or 10
    theMapGenerationTable.Seed = theMapGenerationTable.Seed or 0
    
    theMapGenerationTable.Scale = theMapGenerationTable.Scale or .5
    theMapGenerationTable.Amplitude = theMapGenerationTable.Amplitude or 25
    theMapGenerationTable.Octaves = theMapGenerationTable.Octaves or 8
    theMapGenerationTable.Persistence = theMapGenerationTable.Persistence or .5
    
    theMapGenerationTable.FallOffOffset = theMapGenerationTable.FallOffOffset or 4
    theMapGenerationTable.FallOffSmoothness = theMapGenerationTable.FallOffSmoothness or 14
    theMapGenerationTable.FilterType = theMapGenerationTable.FilterType or 0

    theMapGenerationTable.DoGenerateColorMap = theMapGenerationTable.DoGenerateColorMap or false
    theMapGenerationTable.DoRandomMapGeneration = theMapGenerationTable.DoRandomMapGeneration or false

    if theMapGenerationTable.Seed == 0 then
        theMapGenerationTable.Seed = math.random(-64000, 64000)
    end

    self.MapSize = math.clamp(theMapGenerationTable.MapSize, 1, 512)
    self.TileSize = math.clamp(theMapGenerationTable.TileSize, 1, 50)

    self.Seed = theMapGenerationTable.Seed
    self.Scale = theMapGenerationTable.Scale 
    self.Amplitude = theMapGenerationTable.Amplitude
    self.Octaves = theMapGenerationTable.Octaves
    self.Persistence = theMapGenerationTable.Persistence

    self.FallOffOffset = theMapGenerationTable.FallOffOffset
    self.FallOffSmoothness = theMapGenerationTable.FallOffSmoothness
    self.FilterType = theMapGenerationTable.FilterType


    self.TileMap = table.create(self.MapSize)

    print("Map settings set")
    return self
end

-- Public Methods

-- Generates a tile map with a noise map colored on top
function Map:GenerateMap(theTerrainTypesTable: table)
    for x = 1, self.MapSize do
        self.TileMap[x] = table.create(self.MapSize) -- Reserving space in memmory beforehand

        for z = 1, self.MapSize do
            -- Noise calculation
            local noiseResult  = PerlinNoise.new({(x + self.Seed) * self.Scale, ( z + self.Seed) * self.Scale}, self.Amplitude, self.Octaves, self.Persistence)
            
            local fallOff = nil
            -- Check which filter if any and calculate accordingly

            if self.FilterType == 1 then
                fallOff = FallOffMap.GenerateSquareFallOff(x, z , self.MapSize)
            elseif self.FilterType == 2 then
                fallOff = FallOffMap.GenerateRadialFallOff(z, x , self.MapSize)
            else
                fallOff = 0
            end

            -- Finaly, transform fall off and substract it from the noise
            noiseResult  -= FallOffMap.Transform(fallOff, self.FallOffOffset, self.FallOffSmoothness)
            noiseResult  = math.clamp(noiseResult +.5  , 0, 1)

            -- Creating tile object and setting metadata via internal tile class
            local newTile = Tile.new()
            local tileInstance = newTile.GameObject
            
            tileInstance.Size = Vector3.new(self.TileSize, self.TileSize, self.TileSize)
            tileInstance.Position = Vector3.new(x * tileInstance.Size.X, tileInstance.Size.Y, z * tileInstance.Size.Z)
            tileInstance.Name = x..","..z

            tileInstance.Color = Color3.new(noiseResult , noiseResult , noiseResult ) -- Draws noise in black and white gradient (also fallback if there is no color data)
            newTile:InitMetadata(noiseResult, theTerrainTypesTable)

            self.TileMap[x][z] = newTile -- table.create reserved the space in table, now tiles ordered 2D-mentionally

            tileInstance.Parent = workspace 
        end
    end
    print("Map generated")
end


-- this function sets ONE prop on off the tile origin (respects both tile and asset sizes)
function Map:SetInstanceOnTile(aTaggedTilesList: string, aTaggedProp: string, aChance: integer, hasRandomOrientation: boolean)
    local taggedTilesList = CollectionService:GetTagged(aTaggedTilesList)
    local taggedpropList = CollectionService:GetTagged(aTaggedProp)

    GenerateProps.InstanceToOrigin(taggedTilesList, taggedpropList, aChance, hasRandomOrientation)
end

-- THis function sets props across the tile, THIS IS TILE SIZE DEPENDANT, BIGGER TILES = MORE PROPS!
function Map:SetInstanceAcrossTile(aTaggedTilesList: string, aTaggedProp: string, aChance: integer, hasRandomOrientation: boolean)
    local taggedTilesList = CollectionService:GetTagged(aTaggedTilesList)
    local taggedpropList = CollectionService:GetTagged(aTaggedProp)
    
    GenerateProps.InstanceAcrossTile(taggedTilesList, taggedpropList, aChance, hasRandomOrientation)
end

-- Transform tile metadata, to new one of a given table, OVERWRITES PREVIOUS DATA!
function Map:TransformTilesFromTag(aTag: string, aTerrainTable: table)
    local seed = math.random(-100000, 100000)
    
    for x = 1, self.MapSize do
        for z = 1, self.MapSize do
            local tile = self.TileMap[x][z]
            local tileInstance = tile.GameObject
            
            local noiseResult  = PerlinNoise.new({(x + seed) * self.Scale, ( z + seed)  * self.Scale}, self.Amplitude, self.Octaves, self.Persistence)
            noiseResult  = math.clamp(noiseResult +.5  , 0, 1)
            
            if CollectionService:HasTag(tileInstance, aTag) then    
                if noiseResult <= aTerrainTable.Attributes.TerrainThreshold then
                    tile:SetMetadata(aTerrainTable)
                end
            end
        end
    end

    print("Tiles transformed")
end


-- Returns LIST of tiles with a given TAG
function Map:GetTilesByTag(aTag: stringg)
    return CollectionService:GetTagged(aTag)
end

-- Returns LIST of tiles with a given attribute
function Map:GetTilesByAttribute(anAttribute)
    local tileTable = {}
    
    for x = 1, self.MapSize do
        for z = 1, self.MapSize do
            local tile = self.TileMap[x][z]
            local tileInstance:BasePart = tile.GameObject

            if tileInstance:GetAttribute(anAttribute) then 
                table.insert(tileTable, tileInstance)
            end

        end
    end

    return tileTable
end


-- Returns LIST of tiles with a given attribute VALUE!
function Map:GetTilesByAttributeValue(anAttribute: string, aValue: any)
    local tileTable = {}
    
    for x = 1, self.MapSize do
        for z = 1, self.MapSize do
            local tile = self.TileMap[x][z]
            local tileInstance:BasePart = tile.GameObject

            if tileInstance:GetAttribute(anAttribute) and tileInstance:GetAttribute(anAttribute) == aValue then 
                table.insert(tileTable, tileInstance)
            end

        end
    end

    return tileTable
end

-- Returns TileMap
function Map:GetTileMap()
    return self.TileMap
end
return Map

















