-- Services
local CollectionService = game:GetService('CollectionService')
local ReplicatedStorage = game:GetService('ReplicatedStorage')

-- Classes
local MapClass = require(game:GetService('ServerStorage').Components.Map)
local FeatureGenerator = require(game:GetService('ServerStorage').Components.FeatureGenerator)
local TileClass = require(game:GetService('ServerStorage').Components.Tile)



local terrainTypes = {
    {
        HeightValue = 0,
        TerrainName = "Ocean",
        BrickColor = BrickColor.new("Bright blue"),
    },
    {
        HeightValue = .1,
        TerrainName = "Littoral",
        BrickColor = BrickColor.new("Cyan"),
    },
    {
        HeightValue = .45,
        TerrainName = "Beach",
        BrickColor = BrickColor.new("Daisy orange"),
    },
    {
        HeightValue = .5,
        TerrainName = "Plain",
        BrickColor = BrickColor.new("Bright green")
    },
    {
        HeightValue = .67,
        TerrainName = "Forest",
        BrickColor = BrickColor.new("Forest green")
    },
    {
        HeightValue = .97,
        TerrainName = "Mountain",
        BrickColor = BrickColor.new("Dark stone grey")
    },
    {
        HeightValue = 1,
        TerrainName = "nil",
        BrickColor = BrickColor.new("Really black")
    }
}

local Tile = TileClass.new()

MapClass.new(terrainTypes, Tile.Asset)

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



