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
Map:UpdateTilesFromTag("Lowland", resourceDistributionTable.Iron.LowlandIron)
Map:UpdateTilesFromTag("Upland", resourceDistributionTable.Iron.UplandIron)
Map:UpdateTilesFromTag("Highland", resourceDistributionTable.Iron.HighlandIron)
Map:UpdateTilesFromTag("Steepland", resourceDistributionTable.Iron.SteeplandIron)
Map:UpdateTilesFromTag("Mountainous", resourceDistributionTable.Iron.MountainousIron)


print(#CollectionService:GetTagged("Iron"))

--//TODO look into moving this somewere else
for _, tile in ipairs(CollectionService:GetTagged("Iron")) do
    local ResourceData = GetWeightedDrop(ResourceWeightedDropTable.Iron) -- returns the Key of the resource
    local depositSize = math.random(ResourceData.Ammount.Min, ResourceData.Ammount.Max)
    tile:SetAttribute("ResourceAmmount", depositSize)
end

wait()
MapGenHelperLib.SetTerrainElevation(Map)

wait(3)
Map.Debug.FilterTiles.filterByColorAndGradient(Map, {"Iron"}, "ResourceAmmount", 0, 1000)



