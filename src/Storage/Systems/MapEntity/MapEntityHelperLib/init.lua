--[[
    This Library was made to clean the Map generation runner namespace as much as possible,
    
]]--

local CollectionService = game:GetService('CollectionService')
local ReplicatedStorage = game:GetService('ReplicatedStorage')

local Utilities = ReplicatedStorage.Utilities
local GetWeightedDrop = require(Utilities.GetWeightedDrop)


local MapEntityHelperLib = {}

function MapEntityHelperLib.SetResourceDepositSize(aResourceTag, aResourceDataTable)
    for _, tile in ipairs(CollectionService:GetTagged(aResourceTag)) do
        local WeightData = GetWeightedDrop(aResourceDataTable.WeightsData) -- returns the Key of the resource

        -- Choosing a random value from  range of selected weight, e.g: Medium[400, 800] <-- num between those 
        local depositSize = math.random(WeightData.Ammount.Min, WeightData.Ammount.Max) 
        tile:SetAttribute("ResourceAmmount", depositSize) 
    end
end

function MapEntityHelperLib.SetTerrainElevation(theMap)
    for x = 1, theMap.MapSize do
        for z = 1, theMap.MapSize do
            local tile = theMap.TileMap[x][z]
            
            local tileInstance: BasePart = tile.GameObject
            local posX = tileInstance.Position.X
            local posZ = tileInstance.Position.Z
            local yOffset = tileInstance:GetAttribute("ElevationOffset")

            tileInstance.Position = Vector3.new(posX, yOffset, posZ )
        end
    end
    print("Terrain Elevated")
end

return MapEntityHelperLib