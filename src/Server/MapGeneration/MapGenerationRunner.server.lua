
local ServerStorage = game:GetService('ServerStorage')


-------------------- Modules --------------------
local MapClass = require(ServerStorage.Systems.MapClass)
local MapGenerationUtilities = require(ServerStorage.Systems.MapGenerationUtilities)
-------------------- Map Generation --------------------
local mapGenerationTable = require(ServerStorage.Components.MapComponents.MapGenerationComponent)

-- Mapping MapGenerationConfig values to the map gen tbable
local Map = MapClass.new(mapGenerationTable)


local terrainTypesTable = require(ServerStorage.Components.MapComponents.TerrainTypesComponent)
Map:GenerateMap(terrainTypesTable.InitialTerrains)

-------------------- Adding Landmarks and smoothing Terrain --------------------
--[[
    If this was not done, we would end up with a huge flat bed of mountains
    so to break the pattern we, add some land marks and depress the terrain a bit
]]

task.wait()
Map:ProcedurallyTransformFromTag("Mountainous", terrainTypesTable.StackedTerrains.Impassable)
Map:ProcedurallyTransformFromTag("Mountainous", terrainTypesTable.StackedTerrains.Depression)
MapGenerationUtilities.SetTerrainElevation(Map)

task.wait() --> these waits is to restart script exhaution timer DO NOT REMOVE IT!
-------------------- Resource Generation --------------------
local RawResourcesTypesTable = require(ServerStorage.Components.MapComponents.RawResourcesComponent)

-- Updating Tiles with their respective resource
task.wait()
local procedurallyGeneratedResources = RawResourcesTypesTable.ProcedurallyGenerated
local randomlyGeneratedResources = RawResourcesTypesTable.RandomlyGenerated

Map:RandomlyUpdateFromTag("UseableTile", randomlyGeneratedResources[1])
Map:RandomlyUpdateFromTag("UseableTile", randomlyGeneratedResources[2]) 

Map:ProcedurallyUpdateFromTag("UseableTile", procedurallyGeneratedResources[1])

-- print(#game:GetService('CollectionService'):GetTagged("UseableTile").. " tiles are usable")
-- Map.DoPrintStatus = true

-------------------- setting resource deposit sizes --------------------
MapGenerationUtilities.SetResourceDepositSize(randomlyGeneratedResources)
MapGenerationUtilities.SetResourceDepositSize(procedurallyGeneratedResources)

-- -------------------- Positioning props/assets on tiles --------------------
task.wait()
Map:PositionInstanceOnTaggedTiles("Iron", randomlyGeneratedResources[1].ExtraData.GameObject, 1, true)
Map:PositionInstanceOnTaggedTiles("Clay", randomlyGeneratedResources[2].ExtraData.GameObject, 1, true)
--Map:PositionInstanceOnTaggedTiles("Timber", nil, 1, true)
MapGenerationUtilities.GenerateTrees()

Map:GenerateRivers()



-- task.wait()
-- Map.Debug.FilterTiles.WhitelistAndGradient(Map, "ResourceAmmount", {

--     procedurallyGeneratedResources[1].ExtraData.Debug,
--     randomlyGeneratedResources[1].ExtraData.Debug,
--     randomlyGeneratedResources[2].ExtraData.Debug,
-- })

--  task.wait()

-- Map.Debug.FilterTiles.Blacklist(Map, {
--     procedurallyGeneratedResources[1].ExtraData.Debug,
--     randomlyGeneratedResources[1].ExtraData.Debug,
--     randomlyGeneratedResources[2].ExtraData.Debug,
-- })


