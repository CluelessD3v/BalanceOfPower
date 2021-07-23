-- Services
local CollectionService = game:GetService('CollectionService')
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local ServerStorage = game:GetService('ServerStorage')


local Utilities = ReplicatedStorage.Utilities

-------------------- Modules --------------------
local MapClass = require(ServerStorage.Systems.MapEntity)
local MapGenHelperLib = require(ServerStorage.Systems.MapGenHelperLib)
local GetWeightedDrop = require(Utilities.GetWeightedDrop)


-------------------- Tables --------------------
local mapGenerationTable = require(ServerStorage.Components.MapGenerationTable)
local ResourceWeightedDropTable = require(ServerStorage.Components.ResourceWeightedDropTable)
local RawResourcesTypesTable = require(ServerStorage.Components.RawResourcesTypesTable)

-------------------- Map Generation --------------------
-- Mapping MapGenerationConfig values to the map gen tbable
local Map = MapClass.new(mapGenerationTable)

local terrainTypesTable = require(ServerStorage.Components.TerrainTypesTable)
Map:GenerateMap(terrainTypesTable.InitialTerrains)

--//TODO Add the different transformed terrain to the terrain types table

Map:TransformFromTag("Mountainous", terrainTypesTable.StackedTerrains.Impassable)
Map:TransformFromTag("Mountainous", terrainTypesTable.StackedTerrains.Depression)

MapGenHelperLib.SetTerrainElevation(Map)
wait()
-------------------- Resource Generation --------------------
-- Updating Tiles with their respective resource
--//TODO, ADD THE FILTERED TAGS TO THE Resource types table
Map:UpdateFromTagRandomly("Tile", RawResourcesTypesTable.Iron, RawResourcesTypesTable.Iron.FilteredTags)
Map:UpdateFromTag("Tile", RawResourcesTypesTable.Timber, RawResourcesTypesTable.Timber.FilteredTags)
Map:UpdateFromTagRandomly("Tile", RawResourcesTypesTable.Clay, RawResourcesTypesTable.Clay.FilteredTags )


-------------------- setting resource deposit sizes --------------------
--//TODO look into moving this somewere else
for _, tile in ipairs(CollectionService:GetTagged("Iron")) do
    local ResourceData = GetWeightedDrop(ResourceWeightedDropTable.Iron) -- returns the Key of the resource
    local depositSize = math.random(ResourceData.Ammount.Min, ResourceData.Ammount.Max)
    tile:SetAttribute("ResourceAmmount", depositSize)
end

for _, tile in ipairs(CollectionService:GetTagged("Timber")) do
    local ResourceData = GetWeightedDrop(ResourceWeightedDropTable.Timber) -- returns the Key of the resource
    local depositSize = math.random(ResourceData.Ammount.Min, ResourceData.Ammount.Max)
    tile:SetAttribute("ResourceAmmount", depositSize)
end

for _, tile in ipairs(CollectionService:GetTagged("Clay")) do
    local ResourceData = GetWeightedDrop(ResourceWeightedDropTable.Clay) -- returns the Key of the resource
    local depositSize = math.random(ResourceData.Ammount.Min, ResourceData.Ammount.Max)
    tile:SetAttribute("ResourceAmmount", depositSize)
end

--[[
Map.Debug.FilterTiles.WhitelistAndGradient(Map, "ResourceAmmount", {

    RawResourcesTypesTable.Timber.Debug,
    RawResourcesTypesTable.Clay.Debug,
    RawResourcesTypesTable.Iron.Debug,
})--]]
wait()
Map.Debug.FilterTiles.Blacklist(Map, {
    RawResourcesTypesTable.Timber.Debug,
    RawResourcesTypesTable.Clay.Debug,
    RawResourcesTypesTable.Iron.Debug,
})