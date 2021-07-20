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
local resourcesTable = require(ServerStorage.Components.ResourcesTable)


-------------------- Map Generation --------------------
-- Mapping MapGenerationConfig values to the map gen tbable
local Map = MapClass.new(mapGenerationTable)

local terrainTypesTable = require(ServerStorage.Components.TerrainTypesTable)
Map:GenerateMap(terrainTypesTable)


wait()
Map:UpdateTilesFromTag("Lowland",
    {
        Threshold = .5, 
        Tags = {"Iron"},
    }
)

for _, tile in ipairs(CollectionService:GetTagged("Iron")) do
    local ResourceData = GetWeightedDrop(resourcesTable.Iron) -- returns the Key 
    local depositSize = math.random(ResourceData.Ammount.Min, ResourceData.Ammount.Max)
    tile:SetAttribute("ResourceAmmount", depositSize)
end

MapGenHelperLib.SetTerrainElevation(Map)

