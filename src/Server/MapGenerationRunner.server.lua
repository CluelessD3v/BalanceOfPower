-- Services
local CollectionService = game:GetService('CollectionService')
local ReplicatedStorage = game:GetService('ReplicatedStorage')

-- Classes
local MapClass = require(game:GetService('ServerStorage').Components.Map)
local TerrainGenerator = require(game:GetService('ServerStorage').Components.TerrainGenerator)
local TileClass = require(game:GetService('ServerStorage').Components.Tile)


local mapGenFieldMap  = {}
local mapGenConfig = ReplicatedStorage.Configuration.MapGenerationConfig

if mapGenConfig.DoRandomMapGeneration.Value then
    mapGenConfig.FallOffOffset.Value = math.random(4,7) 
    mapGenConfig.FallOffSmoothness.Value = math.random(4,7)

    mapGenConfig.Amplitude.Value = math.random(24, 28)
    mapGenConfig.Persistence.Value = Random.new():NextNumber(.48, .515 )
    mapGenConfig.Octaves.Value = math.random(6, 9)
    mapGenConfig.Scale.Value =Random.new():NextNumber(.46, .52)

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
mapGenFieldMap.Persistence =  math.clamp(mapGenConfig.Persistence.Value, .01, 1)
mapGenFieldMap.FallOffOffset =  math.clamp(mapGenConfig.FallOffOffset.Value, 1, 12)
mapGenFieldMap.FallOffSmoothness =  math.clamp(mapGenConfig.FallOffSmoothness.Value, 1, 12)





local terrainTypes = {
    Ocean = {
        HeightValue = .1,
        TerrainName = "Ocean"
    },
    Littoral = {
        HeightValue = .45,
        TerrainName = "Littoral"
    },
    Beach = {
        HeightValue = .5,
        TerrainName = "Beach"
    },
    Plain = {
        HeightValue = .7,
        TerrainName = "Plain"
    },
    Forest = {
        HeightValue = .99,
        TerrainName = "Forest"
    },
    Mountain = {
        HeightValue = 1,
        TerrainName = "Mountain"
    },
}

local tile = TileClass.new()
local map = MapClass.new(mapGenFieldMap, tile, terrainTypes)

if map.Generated then
    TerrainGenerator.GenerateForest(CollectionService:GetTagged("Forest"))
    wait()
    TerrainGenerator.GenerateGrass(CollectionService:GetTagged("Plain"))
end

--print(mapGenFieldMap)
--print(map)
--print(#CollectionService:GetTagged("Tile"))

