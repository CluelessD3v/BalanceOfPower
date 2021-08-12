
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
    Map:RandomlyTransformFromTag("UsableTile", RawResourcesTypesTable.Iron, RawResourcesTypesTable.Iron.FilteredTags)
    Map:ProcedurallyUpdateFromTag("UsableTile", RawResourcesTypesTable.Timber, RawResourcesTypesTable.Timber.FilteredTags)
    Map:RandomlyTransformFromTag("UsableTile", RawResourcesTypesTable.Clay, RawResourcesTypesTable.Clay.FilteredTags )

    print(#game:GetService('CollectionService'):GetTagged("UsableTile"))
    Map.DoPrintStatus = true


    -------------------- setting resource deposit sizes --------------------
    -->//TODO FIXCON3 Check if this can be rafactored into a general "SetAttributeFomTag" function or something like that 
    Map.HelperLib.SetResourceDepositSize("Timber", RawResourcesTypesTable.Timber)
    Map.HelperLib.SetResourceDepositSize("Iron", RawResourcesTypesTable.Iron)
    Map.HelperLib.SetResourceDepositSize("Clay", RawResourcesTypesTable.Clay)

    task.wait()
    Map:PositionInstanceOnTaggedTiles("Timber", game.ServerStorage.Assets.TerrainAssets.Trees:GetChildren(), 1, true)

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


