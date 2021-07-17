-- Services
local CollectionService = game:GetService('CollectionService')
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local ServerStorage = game:GetService('ServerStorage')

local MapClass = require(game:GetService('ServerStorage').Systems.Map)
-- Mapping MapGenerationConfig values to the map gen tbable
local mapGenFolder = ReplicatedStorage.Configuration.MapGenerationConfig
local mapGenerationTable = {}
mapGenerationTable.MapSize = mapGenFolder.MapSize.Value
mapGenerationTable.TileSize = mapGenFolder.TileSize.Value
mapGenerationTable.Seed = mapGenFolder.Seed.Value
mapGenerationTable.Scale = mapGenFolder.Scale.Value
mapGenerationTable.Amplitude = mapGenFolder.Amplitude.Value
mapGenerationTable.Octaves = mapGenFolder.Octaves.Value
mapGenerationTable.Persistence = mapGenFolder.Persistence.Value
mapGenerationTable.FallOffOffset = mapGenFolder.FallOffOffset.Value
mapGenerationTable.FallOffSmoothness = mapGenFolder.FallOffSmoothness.Value
mapGenerationTable.FilterType = mapGenFolder.FilterType.Value

local Map = MapClass.new(mapGenerationTable)

local terrainTypesTable = require(ServerStorage.Components.TerrainTypesTable)
Map:GenerateMap(terrainTypesTable)


Map:TransformTilesFromTag("Mountainous", {
    TerrainThreshold = .45   ,
    ElevationOffset = 14,
    TerrainColor = BrickColor.new("Medium stone grey"),
    TerrainTag = "Impassable",
})


Map:TransformTilesFromTag("Lowland", {
    TerrainThreshold = .1   ,
    ElevationOffset = 4,
    TerrainColor = BrickColor.new("Artichoke"),
    TerrainTag = "Lowland",
})


wait()

