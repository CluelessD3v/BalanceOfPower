
local ServerStorage = game:GetService('ServerStorage')


-------------------- Modules --------------------
local MapClass = require(ServerStorage.Systems.MapEntity)

-------------------- Map Generation --------------------
local mapGenerationTable = require(ServerStorage.Components.MapEntityComponents.MapGenerationComponent)

-- Mapping MapGenerationConfig values to the map gen tbable
local Map = MapClass.new(mapGenerationTable)


local terrainTypesTable = require(ServerStorage.Components.MapEntityComponents.TerrainTypesComponent)
Map:GenerateMap(terrainTypesTable.InitialTerrains)

-------------------- Adding Landmarks and smoothing Terrain --------------------
--[[
    If this was not done, we would end up with a huge flat bed of mountains
    so to break the pattern we, add some land marks and depress the terrain a bit
]]
Map:ProcedurallyTransformFromTag("Mountainous", terrainTypesTable.StackedTerrains.Impassable)
Map:ProcedurallyTransformFromTag("Mountainous", terrainTypesTable.StackedTerrains.Depression)
Map.HelperLib.SetTerrainElevation(Map)

task.wait() --> these waits is to restart script exhaution timer DO NOT REMOVE IT!
-------------------- Resource Generation --------------------
local RawResourcesTypesTable = require(ServerStorage.Components.MapEntityComponents.RawResourcesComponent)

-- Updating Tiles with their respective resource
Map:RandomlyTransformFromTag("UsableTile", RawResourcesTypesTable.Iron, RawResourcesTypesTable.Iron.ExtraData.FilteredTags)
Map:RandomlyTransformFromTag("UsableTile", RawResourcesTypesTable.Clay, RawResourcesTypesTable.Clay.ExtraData.FilteredTags )
Map:ProcedurallyUpdateFromTag("UsableTile", RawResourcesTypesTable.Timber, RawResourcesTypesTable.Timber.ExtraData.FilteredTags)


print(#game:GetService('CollectionService'):GetTagged("UsableTile").. " tiles are usable")
Map.DoPrintStatus = true


-------------------- setting resource deposit sizes --------------------
Map.HelperLib.SetResourceDepositSize("Timber", RawResourcesTypesTable.Timber)
Map.HelperLib.SetResourceDepositSize("Iron", RawResourcesTypesTable.Iron)
Map.HelperLib.SetResourceDepositSize("Clay", RawResourcesTypesTable.Clay)

-------------------- Positioning props/assets on tiles --------------------
task.wait()
Map:PositionInstanceOnTaggedTiles("Iron", RawResourcesTypesTable.Iron.ExtraData.GameObject, 1, true)
Map:PositionInstanceOnTaggedTiles("Clay", RawResourcesTypesTable.Clay.ExtraData.GameObject, 1, true)
Map:PositionInstanceOnTaggedTiles("Timber", nil, 1, true)


-- task.wait()
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


