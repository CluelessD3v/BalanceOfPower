-- Services
local CollectionService = game:GetService('CollectionService')
local ReplicatedStorage = game:GetService('ReplicatedStorage')

-- Classes
local MapClass = require(game:GetService('ServerStorage').Components.Map)
local FeatureGenerator = require(game:GetService('ServerStorage').Components.FeatureGenerator)
local TileClass = require(game:GetService('ServerStorage').Components.Tile)

-- Mapping MapGenerationConfig values to the map gen table
local mapGenFolder = ReplicatedStorage.Configuration.MapGenerationConfig
local mapGenerationTable = {}
mapGenerationTable.MapSize = mapGenFolder.MapSize.Value
mapGenerationTable.TileSize = mapGenFolder.TileSize.Value
mapGenerationTable.DoRandomMapGeneration = mapGenFolder.DoRandomMapGeneration.Value
mapGenerationTable.DoGenerateColorMap = mapGenFolder.DoGenerateColorMap.Value
mapGenerationTable.Seed = mapGenFolder.Seed.Value
mapGenerationTable.Scale = mapGenFolder.Scale.Value
mapGenerationTable.Amplitude = mapGenFolder.Amplitude.Value
mapGenerationTable.Octaves = mapGenFolder.Octaves.Value
mapGenerationTable.Persistence = mapGenFolder.Persistence.Value
mapGenerationTable.FallOffOffset = mapGenFolder.FallOffOffset.Value
mapGenerationTable.FallOffSmoothness = mapGenFolder.FallOffSmoothness.Value
mapGenerationTable.FilterType = mapGenFolder.FilterType.Value



--[[
    the mapping method to set tile metadata based on the given terrain type table WILL NOT REACH THE LAST VALUE, add a place holder one at the end, e.g:
    tab = {1, 2, 3, 4, 5, nil} <- place holder value
                       ^ penultimate value is the actual LAST!

    --]]
local terrainTypesTable = {
    {
        TerrainThreshold = 0,
        Elevation = 1,
        TerrainColor = BrickColor.new("Bright blue"),
        TerrainTags = {"Ocean", "Water"},

    },
    {
        TerrainThreshold = .35,
        Elevation = 1,
        TerrainColor = BrickColor.new("Cyan"),
        TerrainTags = {"Littoral", "Water"},
    },
    {
        TerrainThreshold = .465,
        Elevation = 3,
        TerrainColor = BrickColor.new("Daisy orange"),
        TerrainTags = {"Beach"},

    },

    {
        TerrainThreshold = .52,
        Elevation = 3,
        TerrainColor = BrickColor.new("Bright green"),
        TerrainTags = {"Plain"},
    },

    
    {
        
        TerrainThreshold = .7,
        Elevation = 3,
        TerrainColor = BrickColor.new("Forest green"),
        TerrainTags = {"Forest"},
        
    },

    {
        TerrainThreshold = .99,
        Elevation = 10,
        TerrainColor = BrickColor.new("Dark stone grey"),
        TerrainTags = {"Mountain"},

    },
    {
        TerrainThreshold = 1,
        TerrainColor = BrickColor.new("Really black"),
        TerrainTags = {"nil"},
    }
}

local Tile = TileClass.new()

local map = MapClass.new(mapGenerationTable, terrainTypesTable, Tile.GameObject)
map:ElevateTerrain(CollectionService:GetTagged("Mountain"))

local TerrainGenerationConfig = ReplicatedStorage.Configuration.TerrainGenerationConfig


--//TODO Use a map class method to get certain tiles

--[[if TerrainGenerationConfig.DoGenerateMountains.Value then
    FeatureGenerator.GenerateGrass(Tile, CollectionService:GetTagged("Plain"))
end

if TerrainGenerationConfig.DoGenerateForest.Value then
    FeatureGenerator.GenerateMountains(Tile, CollectionService:GetTagged("Mountain"))
end

--//TODO TEMPORAL, FOREST STORE LUMBER RESOURCE!
if TerrainGenerationConfig.DoGenerateGrass.Value then
    FeatureGenerator.GenerateForest(Tile, CollectionService:GetTagged("Forest"))
end

--]]

