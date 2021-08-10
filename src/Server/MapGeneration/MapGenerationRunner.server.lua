
local ServerStorage = game:GetService('ServerStorage')


-------------------- Modules --------------------
local MapClass = require(ServerStorage.Systems.MapEntity)

-------------------- Map Generation --------------------
local mapGenerationTable = require(ServerStorage.Components.MapEntityComponents.MapGenerationComponent)

-- Mapping MapGenerationConfig values to the map gen tbable
local Map = MapClass.new(mapGenerationTable)

local terrainTypesTable = require(ServerStorage.Components.MapEntityComponents.TerrainTypesComponent)
Map:GenerateMap(terrainTypesTable.InitialTerrains)


Map:TransformFromTag("Mountainous", terrainTypesTable.StackedTerrains.Impassable)
Map:TransformFromTag("Mountainous", terrainTypesTable.StackedTerrains.Depression)
Map.HelperLib.SetTerrainElevation(Map)

task.wait() --> these waits is to restart script exhaution timer DO NOT REMOVE IT!
-------------------- Resource Generation --------------------
local RawResourcesTypesTable = require(ServerStorage.Components.MapEntityComponents.RawResourcesComponent)

-- Updating Tiles with their respective resource
Map:UpdateFromTagRandomly("Tile", RawResourcesTypesTable.Iron, RawResourcesTypesTable.Iron.FilteredTags)
Map:UpdateFromTag("Tile", RawResourcesTypesTable.Timber, RawResourcesTypesTable.Timber.FilteredTags)
Map:UpdateFromTagRandomly("Tile", RawResourcesTypesTable.Clay, RawResourcesTypesTable.Clay.FilteredTags )

task.wait()
-------------------- setting resource deposit sizes --------------------
Map.HelperLib.SetResourceDepositSize("Timber", RawResourcesTypesTable.Timber)
Map.HelperLib.SetResourceDepositSize("Iron", RawResourcesTypesTable.Iron)
Map.HelperLib.SetResourceDepositSize("Clay", RawResourcesTypesTable.Clay)


Map:PositionInstanceOnTaggedTiles("Timber", game.ServerStorage.Assets.TerrainAssets.Trees:GetChildren(), 1, true)

-- Map.Debug.FilterTiles.WhitelistAndGradient(Map, "ResourceAmmount", {

--     RawResourcesTypesTable.Timber.Debug,
--     RawResourcesTypesTable.Clay.Debug,
--     RawResourcesTypesTable.Iron.Debug,
-- })

-- task.wait(10)

-- Map.Debug.FilterTiles.Blacklist(Map, {
--     RawResourcesTypesTable.Timber.Debug,
--     RawResourcesTypesTable.Clay.Debug,
--     RawResourcesTypesTable.Iron.Debug,
-- })


