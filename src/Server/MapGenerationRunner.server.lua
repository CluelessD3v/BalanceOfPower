-- Services
local CollectionService = game:GetService('CollectionService')
local ReplicatedStorage = game:GetService('ReplicatedStorage')

-- Classes
local MapClass = require(game:GetService('ServerStorage').Components.Map)
local FeatureGenerator = require(game:GetService('ServerStorage').Components.FeatureGenerator)
local TileClass = require(game:GetService('ServerStorage').Components.Tile)




local terrainTypes = {
    Ocean = {
        HeightValue = .1,
        TerrainName = "Ocean",
        BrickColor = BrickColor.new("Bright blue"),
    },
    Littoral = {
        HeightValue = .5,
        TerrainName = "Littoral",
        BrickColor = BrickColor.new("Cyan"),
    },
    Beach = {
        HeightValue = .55,
        TerrainName = "Beach",
        BrickColor = BrickColor.new("Daisy orange")
    },
    Plain = {
        HeightValue = .7,
        TerrainName = "Plain",
        BrickColor = BrickColor.new("Bright green")
    },
    Forest = {
        HeightValue = .97,
        TerrainName = "Forest",
        BrickColor = BrickColor.new("Forest green")
    },
    Mountain = {
        HeightValue = 1,
        TerrainName = "Mountain",
        BrickColor = BrickColor.new("Dark stone grey")
    },
}

local Tile = TileClass.new()
local map = MapClass.new(terrainTypes, Tile.Asset)

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



