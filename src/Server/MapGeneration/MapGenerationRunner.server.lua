-- Services
local CollectionService = game:GetService('CollectionService')
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local ServerStorage = game:GetService('ServerStorage')

-- Modules
local MapClass = require(ServerStorage.Systems.MapEntity)
local MapGenHelperLib = require(ServerStorage.Systems.MapGenHelperLib)

-- Mapping MapGenerationConfig values to the map gen tbable

-- Map generation
local mapGenerationTable = require(ServerStorage.Components.MapGenerationTable)
local Map = MapClass.new(mapGenerationTable)

local terrainTypesTable = require(ServerStorage.Components.TerrainTypesTable)
Map:GenerateMap(terrainTypesTable)
wait()
Map:UpdateTilesFromTag("Lowland",
{
    Properties = {},
    Tags = {"Iron"},
    Attributes = {
        Threshold = .3
    },
})

MapGenHelperLib.SetTerrainElevation(Map)
Map.Debug.FilterTiles.Whitelist(Map, {"Iron"})
