-- Services
local CollectionService = game:GetService('CollectionService')
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local ServerStorage = game:GetService('ServerStorage')



-------------------- Modules --------------------
local MapClass = require(ServerStorage.Systems.MapEntity)

-------------------- Map Generation --------------------
local mapGenerationTable = require(ServerStorage.Components.MapGenerationTable)

-- Mapping MapGenerationConfig values to the map gen tbable
local Map = MapClass.new(mapGenerationTable)

local terrainTypesTable = require(ServerStorage.Components.TerrainTypesTable)
Map:GenerateMap(terrainTypesTable.InitialTerrains)

--//TODO Add the different transformed terrain to the terrain types table

Map:TransformFromTag("Mountainous", terrainTypesTable.StackedTerrains.Impassable)
Map:TransformFromTag("Mountainous", terrainTypesTable.StackedTerrains.Depression)
Map.HelperLib.SetTerrainElevation(Map)
wait()
-------------------- Resource Generation --------------------
local RawResourcesTypesTable = require(ServerStorage.Components.RawResourcesTypesTable)

-- Updating Tiles with their respective resource
Map:UpdateFromTagRandomly("Tile", RawResourcesTypesTable.Iron, RawResourcesTypesTable.Iron.FilteredTags)
Map:UpdateFromTag("Tile", RawResourcesTypesTable.Timber, RawResourcesTypesTable.Timber.FilteredTags)
Map:UpdateFromTagRandomly("Tile", RawResourcesTypesTable.Clay, RawResourcesTypesTable.Clay.FilteredTags )


-------------------- setting resource deposit sizes --------------------

Map.HelperLib.SetResourceDepositSize("Timber", RawResourcesTypesTable.Timber)
Map.HelperLib.SetResourceDepositSize("Iron", RawResourcesTypesTable.Iron)
Map.HelperLib.SetResourceDepositSize("Clay", RawResourcesTypesTable.Clay)

