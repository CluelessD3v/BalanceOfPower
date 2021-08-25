--[[
    This Library was made to clean the Map generation runner namespace as much as possible,
    
]]--

local CollectionService = game:GetService('CollectionService')
local ReplicatedStorage = game:GetService('ReplicatedStorage')

local Utilities = ReplicatedStorage.Utilities
local WeightedChoice = require(Utilities.WeightedChoice)


local MapEntityHelperLib = {}

function MapEntityHelperLib.SetResourceDepositSize(aResourceDataTable)
    for _, resourceData in ipairs(aResourceDataTable) do
        local lookUpTag = resourceData.ExtraData.LookUpTag
        for _, tile in ipairs(CollectionService:GetTagged(lookUpTag)) do
            local WeightData = WeightedChoice(resourceData.ExtraData.WeightsData) -- returns the Key of the resource
    
            -- Choosing a random value from  range of selected weight, e.g: Medium[400, 800] <-- num between those 
            local depositSize = math.random(WeightData.Ammount.Min, WeightData.Ammount.Max) 
            tile:SetAttribute("ResourceAmmount", depositSize) 
        end
    end
end

--//TODO DEFCON3: Put this in the tile class, I reckon it would be nice to be able to move multiple units in this fashion
function MapEntityHelperLib.GenerateTrees()
    local posTable = {
        {.25, 0, .25},
        {-.25, 0, .25},
        {.25, 0, -.25},
        {-.25, 0, -.25}
    }
    
    local function PositionInTile(prop, tile, positionTable)
        local yOffset =  tile.Size.Y/2 + prop.Size.Y/2 * .5
        local xOffset = tile.Size.X * positionTable[1]
        local zOffset = tile.Size.Z * positionTable[3]	
        prop.Position = tile.Position + Vector3.new(xOffset, yOffset, zOffset)
        --prop.Orientation = Vector3.new(0, math.random(0, 360), 0)
        prop.Size /= 1.5
        prop.Parent = tile.TreeGroup
    end

    local function GetProp(propList)
        return propList[math.random(1, #propList)]:Clone()
    end

    local props = workspace.Props.Trees:GetChildren()
    
    for _, tile in ipairs(CollectionService:GetTagged("Timber")) do
        local treeGroup = Instance.new("Model")
        treeGroup.Name = "TreeGroup"
        treeGroup.Parent = tile
        for i = 1, 4 do
            PositionInTile(GetProp(props), tile, posTable[i])
        end    
    
        treeGroup:PivotTo(treeGroup:GetPivot() * CFrame.Angles(0, math.random(0, 360), 0))
    end
end


function MapEntityHelperLib.SetTerrainElevation(theMap)
    for x = 1, theMap.MapSize do
        for z = 1, theMap.MapSize do
            local tile = theMap._TileMap[x][z]
            
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