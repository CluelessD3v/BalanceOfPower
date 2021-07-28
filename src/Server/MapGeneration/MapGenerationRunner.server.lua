
local ServerStorage = game:GetService('ServerStorage')



-------------------- Modules --------------------
local MapClass = require(ServerStorage.Systems.MapEntity)

-------------------- Map Generation --------------------
local mapGenerationTable = require(ServerStorage.Components.MapEntityComponents.MapGenerationComponent)

-- Mapping MapGenerationConfig values to the map gen tbable
local Map = MapClass.new(mapGenerationTable)

local terrainTypesTable = require(ServerStorage.Components.MapEntityComponents.TerrainTypesComponent)
Map:GenerateMap(terrainTypesTable.InitialTerrains)

--//TODO Add the different transformed terrain to the terrain types table

Map:TransformFromTag("Mountainous", terrainTypesTable.StackedTerrains.Impassable)
Map:TransformFromTag("Mountainous", terrainTypesTable.StackedTerrains.Depression)
Map.HelperLib.SetTerrainElevation(Map)
wait()
-------------------- Resource Generation --------------------
local RawResourcesTypesTable = require(ServerStorage.Components.MapEntityComponents.RawResourcesComponent)

-- Updating Tiles with their respective resource
Map:UpdateFromTagRandomly("Tile", RawResourcesTypesTable.Iron, RawResourcesTypesTable.Iron.FilteredTags)
Map:UpdateFromTag("Tile", RawResourcesTypesTable.Timber, RawResourcesTypesTable.Timber.FilteredTags)
Map:UpdateFromTagRandomly("Tile", RawResourcesTypesTable.Clay, RawResourcesTypesTable.Clay.FilteredTags )


-------------------- setting resource deposit sizes --------------------
--//TODO look into moving this somewere else
Map.HelperLib.SetResourceDepositSize("Timber", RawResourcesTypesTable.Timber)
Map.HelperLib.SetResourceDepositSize("Iron", RawResourcesTypesTable.Iron)
Map.HelperLib.SetResourceDepositSize("Clay", RawResourcesTypesTable.Clay)

Map.Debug.FilterTiles.WhitelistAndGradient(Map, "ResourceAmmount", {

    RawResourcesTypesTable.Timber.Debug,
    RawResourcesTypesTable.Clay.Debug,
    RawResourcesTypesTable.Iron.Debug,
})

wait(10)

Map.Debug.FilterTiles.Blacklist(Map, {
    RawResourcesTypesTable.Timber.Debug,
    RawResourcesTypesTable.Clay.Debug,
    RawResourcesTypesTable.Iron.Debug,
})
