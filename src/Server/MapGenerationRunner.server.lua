-- Services
local CollectionService = game:GetService('CollectionService')
local ReplicatedStorage = game:GetService('ReplicatedStorage')

-- Classes
local MapClass = require(game:GetService('ServerStorage').Components.Map)
local FeatureGenerator = require(game:GetService('ServerStorage').Components.FeatureGenerator)
local TileClass = require(game:GetService('ServerStorage').Components.Tile)


local mapGenFieldMap  = {}
local mapGenConfig = ReplicatedStorage.Configuration.MapGenerationConfig

if mapGenConfig.DoRandomMapGeneration.Value then
    mapGenConfig.FallOffOffset.Value = math.random(4,8) 
    mapGenConfig.FallOffSmoothness.Value = math.random(4,8)

    mapGenConfig.Amplitude.Value = math.random(24, 28)
    mapGenConfig.Persistence.Value = Random.new():NextNumber(.48, .52 )
    mapGenConfig.Octaves.Value = math.random(6, 9)
    mapGenConfig.Scale.Value = Random.new():NextNumber(.48, .53)

end

if mapGenConfig.Seed.Value == 0 then
    mapGenConfig.Seed.Value = math.random(-32768, 32768)
end

mapGenFieldMap.MapSize = math.clamp(mapGenConfig.MapSize.Value, 4, 512)
mapGenFieldMap.TileSize = math.clamp(mapGenConfig.TileSize.Value, 1, 100)
mapGenFieldMap.Seed = math.clamp(mapGenConfig.Seed.Value, -32768, 32768)

mapGenFieldMap.Amplitude =  math.clamp(mapGenConfig.Amplitude.Value, 1, 100)
mapGenFieldMap.Scale =  math.clamp(mapGenConfig.Scale.Value, .1, 1)
mapGenFieldMap.Octaves =  math.clamp(mapGenConfig.Octaves.Value, 1, 100)
mapGenFieldMap.Persistence =  math.clamp(mapGenConfig.Persistence.Value, .1, 1)
mapGenFieldMap.FallOffOffset =  math.clamp(mapGenConfig.FallOffOffset.Value, 1, 100)
mapGenFieldMap.FallOffSmoothness =  math.clamp(mapGenConfig.FallOffSmoothness.Value, 1, 100)



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


--// Reminder N69 OF MAKING A FUCKING DEBUG TOOL MATE.
local map = MapClass.new(mapGenFieldMap, Tile, terrainTypes)
wait(1)
--FeatureGenerator.GenerateMountains(Tile, CollectionService:GetTagged("Mountain"))
wait(1)
--FeatureGenerator.GenerateForest(Tile, CollectionService:GetTagged("Forest"))
wait(1)
--FeatureGenerator.GenerateGrass(Tile, CollectionService:GetTagged("Plain"))

--print(mapGenFieldMap)
--print(map)
--print(#CollectionService:GetTagged("Tile"))

