-- Services
local CollectionService = game:GetService('CollectionService')
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local ServerStorage = game:GetService('ServerStorage')


local Utilities = ReplicatedStorage.Utilities

-- Modules
local MapClass = require(ServerStorage.Systems.MapEntity)
local MapGenHelperLib = require(ServerStorage.Systems.MapGenHelperLib)
local GetWeightedDrop = require(Utilities.GetWeightedDrop)

-- Mapping MapGenerationConfig values to the map gen tbable

-- Map generation
local mapGenerationTable = require(ServerStorage.Components.MapGenerationTable)
local Map = MapClass.new(mapGenerationTable)

local terrainTypesTable = require(ServerStorage.Components.TerrainTypesTable)
Map:GenerateMap(terrainTypesTable)
wait()
Map:UpdateTilesFromTag("Lowland",
{
    Properties = {},
    Tags = {"Iron"},
    Attributes = {
        Threshold = .1
    },
})


local Iron = {
    {
        Ammount = "Small",
        Weight = 30
    },

    {
        Ammount = "Medium",
        Weight = 50
    },
    
    {
        Ammount = "Big",
        Weight = 5
    },
}



for _, tile in ipairs(CollectionService:GetTagged("Iron")) do
    local ammount = GetWeightedDrop(Iron)
    tile:SetAttribute("ResourceAmmount", ammount)
end

--MapGenHelperLib.SetTerrainElevation(Map)


Map.Debug.FilterTiles.Whitelist(Map, {"Iron"})
