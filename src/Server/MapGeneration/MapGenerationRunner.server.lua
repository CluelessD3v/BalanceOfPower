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
local resourceDistributionTable = require(ServerStorage.Components.ResourceDistributionTable)

-------------------- Map Generation --------------------
-- Mapping MapGenerationConfig values to the map gen tbable
local Map = MapClass.new(mapGenerationTable)

local terrainTypesTable = require(ServerStorage.Components.TerrainTypesTable)
Map:GenerateMap(terrainTypesTable)


wait()

-------------------- Resource Generation --------------------
-- Updating Tiles with their respective resource

Map:UpdateFromTagRandomly("Lowland", resourceDistributionTable.Iron.LowlandIron)
--[[Map:UpdateFromTagRandomly("Upland", resourceDistributionTable.Iron.UplandIron, function()end)
Map:UpdateFromTagRandomly("Highland", resourceDistributionTable.Iron.HighlandIron, function()end)
Map:UpdateFromTagRandomly("Steepland", resourceDistributionTable.Iron.SteeplandIron, function()end)
Map:UpdateFromTagRandomly("Mountainous", resourceDistributionTable.Iron.MountainousIron, function()end)
--]]
wait()

Map:UpdateFromTagRandomly("Lowland", resourceDistributionTable.Timber.LowlandTimber, {"HasResource"})

print(#CollectionService:GetTagged("Iron"), "Are Iron")
print(#CollectionService:GetTagged("Timber"), "Are timber")

--//TODO look into moving this somewere else
for _, tile in ipairs(CollectionService:GetTagged("Iron")) do
    local ResourceData = GetWeightedDrop(ResourceWeightedDropTable.Iron) -- returns the Key of the resource
    local depositSize = math.random(ResourceData.Ammount.Min, ResourceData.Ammount.Max)
    tile:SetAttribute("ResourceAmmount", depositSize)
end

for _, tile in ipairs(CollectionService:GetTagged("Timber")) do
    local ResourceData = GetWeightedDrop(ResourceWeightedDropTable.Iron) -- returns the Key of the resource
    local depositSize = math.random(ResourceData.Ammount.Min, ResourceData.Ammount.Max)
    tile:SetAttribute("ResourceAmmount", depositSize)
end


wait()
MapGenHelperLib.SetTerrainElevation(Map)


Map.Debug.FilterTiles.Blacklist(Map, {"Iron", "Timber"})


