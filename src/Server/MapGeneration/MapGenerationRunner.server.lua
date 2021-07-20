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

local sum = 0
for _, entry in pairs(Iron) do
    sum = sum + entry.Weight
end



local resource = nil


local function getResource()
    local randI = math.random(sum)
    for _, entry in pairs(Iron) do
        if randI <= entry.Weight then
            return entry.Ammount     
        else
            randI = randI - entry.Weight   
        end
    end
end


for _, tile in ipairs(CollectionService:GetTagged("Iron")) do
    local ammount = GetWeightedDrop(Iron)
    print(ammount)
    tile:SetAttribute("ResourceAmmount", ammount)
end

--MapGenHelperLib.SetTerrainElevation(Map)


Map.Debug.FilterTiles.Whitelist(Map, {"Iron"})
