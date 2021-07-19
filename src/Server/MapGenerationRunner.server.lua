-- Services
local CollectionService = game:GetService('CollectionService')
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local ServerStorage = game:GetService('ServerStorage')

local MapClass = require(game:GetService('ServerStorage').Systems.Map)
-- Mapping MapGenerationConfig values to the map gen tbable

-- Map generation
local mapGenerationTable = require(ServerStorage.Components.MapGenerationTable)
local Map = MapClass.new(mapGenerationTable)

local terrainTypesTable = require(ServerStorage.Components.TerrainTypesTable)
Map:GenerateMap(terrainTypesTable)


local LowlandIronTile = {
    Properties = {
        BrickColor = BrickColor.new("Moss"),
    },

    Attributes = {
        TerrainThreshold = .025,
        ElevationOffset = 4,
        ResourceAmmount = 0,
    },

    Tags = {},
}



wait()


Map:TransformTilesFromTag("Lowland", LowlandIronTile)

wait()

for x = 1, Map.MapSize do
    for z = 1, Map.MapSize do
        local tile = Map.TileMap[x][z] 
        local tileInstance: BasePart = tile.GameObject
        local posX = tileInstance.Position.X
        local posZ = tileInstance.Position.Z
        local yOffset = tileInstance:GetAttribute("ElevationOffset")

        tileInstance.Position = Vector3.new(posX, yOffset, posZ )
    end
end


for _, taggedTile in ipairs (CollectionService:GetTagged("Lowland")) do
    if CollectionService:HasTag(taggedTile, "Iron") then
        Map:SetInstanceAcrossTile(taggedTile, "IronProp", 3, true)

    end
end
