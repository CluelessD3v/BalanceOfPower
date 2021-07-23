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
Map:GenerateMap(terrainTypesTable)
MapGenHelperLib.SetTerrainElevation(Map)

--//TODO Add the different transformed terrain to the terrain types table

Map:TransformFromTag("Mountainous", {
    
        Threshold = 0,
        Properties = {
            BrickColor = BrickColor.new("Medium stone grey")
        },
        Attributes = {
        ElevationOffset = 10,

        },  
        Tags = {"Impassable"},
})


-------------------- Resource Generation --------------------
-- Updating Tiles with their respective resource
--//TODO, ADD THE FILTERED TAGS TO THE Resource types table
Map:UpdateFromTagRandomly("Tile", RawResourcesTypesTable.Iron.LowlandIron, {"Impassable", "HasResource", "WaterBody", "Beach"})

--[[Map:UpdateFromTagRandomly("Upland", RawResourcesTypesTable.Iron.UplandIron, {"Impassable", "HasResource"})
Map:UpdateFromTagRandomly("Highland", RawResourcesTypesTable.Iron.HighlandIron, {"Impassable", "HasResource"})
Map:UpdateFromTagRandomly("Steepland", RawResourcesTypesTable.Iron.SteeplandIron, {"Impassable", "HasResource"})
Map:UpdateFromTagRandomly("Mountainous", RawResourcesTypesTable.Iron.MountainousIron, {"Impassable", "HasResource"})

wait()

Map:UpdateFromTag("Lowland", RawResourcesTypesTable.Timber.LowlandTimber, {"Impassable", "HasResource"})
Map:UpdateFromTag("Upland", RawResourcesTypesTable.Timber.UplandTimber, {"Impassable", "HasResource"})
Map:UpdateFromTag("Highland", RawResourcesTypesTable.Timber.HighlandTimber, {"Impassable", "HasResource"})
Map:UpdateFromTag("Steepland", RawResourcesTypesTable.Timber.SteeplandTimber, {"Impassable", "HasResource"})
Map:UpdateFromTag("Mountainous", RawResourcesTypesTable.Timber.MountainousTimber, {"Impassable", "HasResource"})

wait()
Map:UpdateFromTagRandomly("Lowland", RawResourcesTypesTable.Clay.LowlandClaw, {"Impassable", "HasResource"})
Map:UpdateFromTagRandomly("Upland", RawResourcesTypesTable.Clay.UplandClay, {"Impassable", "HasResource"})
Map:UpdateFromTagRandomly("Highland", RawResourcesTypesTable.Clay.HighlandClay, {"Impassable", "HasResource"})

print(#CollectionService:GetTagged("Iron"), "Are Iron")
print(#CollectionService:GetTagged("Timber"), "Are timber")
print(#CollectionService:GetTagged("Clay"), "Are Clay")

--]]

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

wait()

Map.Debug.FilterTiles.Blacklist(Map,{
    
    RawResourcesTypesTable.Timber.Debug,
    RawResourcesTypesTable.Iron.Debug,
    RawResourcesTypesTable.Clay.Debug
    

})


