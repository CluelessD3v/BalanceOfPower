-- Services
local CollectionService = game:GetService('CollectionService')
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local ServerStorage = game:GetService('ServerStorage')

local MapClass = require(game:GetService('ServerStorage').Systems.Map)
-- Mapping MapGenerationConfig values to the map gen tbable

-- Map generation
local mapGenerationTable = require(ServerStorage.Components.MapGenerationTable)
local Map = MapClass.new(mapGenerationTable)

local terrainTypesTable = require(ServerStorage.Components.TerrainTypesTable)
Map:GenerateMap(terrainTypesTable)





