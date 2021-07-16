local ReplicatedStorage = game:GetService('ReplicatedStorage')
local CollectionService = game:GetService('CollectionService')

local PerlinNoise = require(script.Parent.PerlinNoise)
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
        note: Values are not fully random, they are selected from a range that keep the map 
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


    self.Tiles = table.create(self.MapSize)

    print("Map settings set")
    return self
end


-- Generates a tile map with a noise map colored on top
function Map:GenerateMap(aTile: BasePart, theTerrainTypesTable: table)
    if not aTile:IsA("BasePart")  then
        error("Tile must be a BasePart!")
    end

    for x = 1, self.MapSize do
        self.Tiles[x] = table.create(self.MapSize) -- Reserving space in memmory beforehand

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
            local tile = Tile.new()
            local tileInstance = tile.GameObject
            tileInstance.Size = Vector3.new(self.TileSize, self.TileSize, self.TileSize)
            tileInstance.Position = Vector3.new(x * tileInstance.Size.X, tileInstance.Size.Y, z * tileInstance.Size.Z)
            tileInstance.Name = x..","..z

            tileInstance.Color = Color3.new(noiseResult , noiseResult , noiseResult ) -- Draws noise in black and white gradient (also fallback if there is no color data)
            tile:SetMetadata(noiseResult, theTerrainTypesTable)

            self.Tiles[x][z] = tileInstance -- table.create reserved the space in table, now tiles ordered 2D-mentionally


            tileInstance.Parent = workspace 
        end
    end
    print("Map generated")
end


-- Sets terrain Terrain color attribute from the tile
function Map:SetTerrainColor()
    for x = 1, self.MapSize do
        for z = 1, self.MapSize do
           local tile = self.Tiles[x][z]
           tile.BrickColor = tile:GetAttribute("TerrainColor")
        end
    end
end


-- Sets elevation based in the ElevationOffset Attribute found in the tile (Given by the TerrainTypesTable)
function Map:SetTerrainElevation()
    for x = 1, self.MapSize do
        for z = 1, self.MapSize do
           local tile = self.Tiles[x][z]
           tile.Position = tile.Position + Vector3.new(0, tile:GetAttribute("ElevationOffset"), 0)
        end
    end
    print("TerrainElevated")
end

-- This function sets props on top of the tile origin
function Map:SetPropOnTile(aTaggedTilesList: string, aTaggedProp: string, aChance: integer, hasRandomOrientation: boolean)
    local taggedTilesList = CollectionService:GetTagged(aTaggedTilesList)
    local taggedpropList = CollectionService:GetTagged(aTaggedProp)

    GenerateProps.InstanceToOrigin(taggedTilesList, taggedpropList, aChance, hasRandomOrientation)
end

-- THis function sets props across the tile, THIS IS TILE SIZE DEPENDANT, BIGGER TILES = MORE PROPS!
function Map:SetPropAcrossTile(aTaggedTilesList: string, aTaggedProp: string, aChance: integer, hasRandomOrientation: boolean)
    local taggedTilesList = CollectionService:GetTagged(aTaggedTilesList)
    local taggedpropList = CollectionService:GetTagged(aTaggedProp)
    
    GenerateProps.InstanceAcrossTile(taggedTilesList, taggedpropList, aChance, hasRandomOrientation)
end


function Map:TransformTilesFromTag(aTaggedTilesList: string, terrainTypeTable: table)
    local seed = math.random(-100000, 100000)
    for x = 1, self.MapSize do
        for z = 1, self.MapSize do
            local tile = self.Tiles[x][z]
            local noiseResult  = PerlinNoise.new({(x + seed) * self.Scale, ( z + seed)  * self.Scale}, self.Amplitude, self.Octaves, self.Persistence)
            noiseResult  = math.clamp(noiseResult +.5  , 0, 1)
            
            if CollectionService:HasTag(tile, aTaggedTilesList) then    
                if noiseResult <= terrainTypeTable.TerrainThreshold then
                    tile.BrickColor = terrainTypeTable.TerrainColor
                    tile.Position = tile.Position + Vector3.new(0, terrainTypeTable.ElevationOffset)
                end    
            end
        end
    end
end






return Map


















