-- Services
local CollectionService = game:GetService('CollectionService')
local ReplicatedStorage = game:GetService('ReplicatedStorage')

-- Classes
local MapClass = require(game:GetService('ServerStorage').Components.Map)
local FeatureGenerator = require(game:GetService('ServerStorage').Components.FeatureGenerator)
local TileClass = require(game:GetService('ServerStorage').Components.Tile)

-- Mapping MapGenerationConfig values to the map gen table
local mapGenFolder = ReplicatedStorage.Configuration.MapGenerationConfig
local mapGenConfigTable = {}
mapGenConfigTable.MapSize = mapGenFolder.MapSize.Value
mapGenConfigTable.TileSize = mapGenFolder.TileSize.Value
mapGenConfigTable.DoRandomMapGeneration = mapGenFolder.DoRandomMapGeneration.Value
mapGenConfigTable.DoGenerateColorMap = mapGenFolder.DoGenerateColorMap.Value
mapGenConfigTable.Seed = mapGenFolder.Seed.Value
mapGenConfigTable.Scale = mapGenFolder.Scale.Value
mapGenConfigTable.Amplitude = mapGenFolder.Amplitude.Value
mapGenConfigTable.Octaves = mapGenFolder.Octaves.Value
mapGenConfigTable.Persistence = mapGenFolder.Persistence.Value
mapGenConfigTable.FallOffOffset = mapGenFolder.FallOffOffset.Value
mapGenConfigTable.FallOffSmoothness = mapGenFolder.FallOffSmoothness.Value
mapGenConfigTable.FilterType = mapGenFolder.FilterType.Value


local terrainTypes = {
    {
        HeightValue = 0,
        TerrainTags = {"Ocean", "Water"},
        BrickColor = BrickColor.new("Bright blue"),
    },
    {
        HeightValue = .45,
        TerrainTags = {"Littoral", "Water"},
        BrickColor = BrickColor.new("Cyan"),
    },
    {
        HeightValue = .49,
        TerrainTags = {"Beach"},
        BrickColor = BrickColor.new("Daisy orange"),
    },

    {
        HeightValue = .55,
        TerrainTags = {"Plain"},
        BrickColor = BrickColor.new("Bright green")
    },

    {
        HeightValue = .78,
        TerrainTags = {"Forest"},
        BrickColor = BrickColor.new("Forest green"),
    },
    {
        HeightValue = .99,
        TerrainTags = {"Mountain"},
        BrickColor = BrickColor.new("Dark stone grey")
    },
    {
        HeightValue = 1,
        TerrainTags = {"nil"},
        BrickColor = BrickColor.new("Really black")
    }
}

local Tile = TileClass.new()

MapClass.new(mapGenConfigTable, terrainTypes, Tile.Asset)

local TerrainGenerationConfig = ReplicatedStorage.Configuration.TerrainGenerationConfig


if TerrainGenerationConfig.DoGenerateMountains.Value then
    FeatureGenerator.GenerateGrass(Tile, CollectionService:GetTagged("Plain"))
end

if TerrainGenerationConfig.DoGenerateForest.Value then
    FeatureGenerator.GenerateMountains(Tile, CollectionService:GetTagged("Mountain"))
end

--//TODO TEMPORAL, FOREST STORE LUMBER RESOURCE!
if TerrainGenerationConfig.DoGenerateGrass.Value then
    FeatureGenerator.GenerateForest(Tile, CollectionService:GetTagged("Forest"))
end



