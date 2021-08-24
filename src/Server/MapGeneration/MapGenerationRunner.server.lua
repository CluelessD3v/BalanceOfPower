
local ServerStorage = game:GetService('ServerStorage')


-------------------- Modules --------------------
local MapClass = require(ServerStorage.Systems.MapEntity)
local MapGenerationUtilities = require(ServerStorage.Systems.MapGenerationUtilities)
-------------------- Map Generation --------------------
local mapGenerationTable = require(ServerStorage.Components.MapComponents.MapGenerationComponent)

-- Mapping MapGenerationConfig values to the map gen tbable
local Map = MapClass.new(mapGenerationTable)


local terrainTypesTable = require(ServerStorage.Components.MapComponents.TerrainTypesComponent)
Map:GenerateMap(terrainTypesTable.InitialTerrains)

-------------------- Adding Landmarks and smoothing Terrain --------------------
--[[
    If this was not done, we would end up with a huge flat bed of mountains
    so to break the pattern we, add some land marks and depress the terrain a bit
]]
Map:ProcedurallyTransformFromTag("Mountainous", terrainTypesTable.StackedTerrains.Impassable)
Map:ProcedurallyTransformFromTag("Mountainous", terrainTypesTable.StackedTerrains.Depression)
MapGenerationUtilities.SetTerrainElevation(Map)

task.wait() --> these waits is to restart script exhaution timer DO NOT REMOVE IT!
-------------------- Resource Generation --------------------
local RawResourcesTypesTable = require(ServerStorage.Components.MapComponents.RawResourcesComponent)

-- Updating Tiles with their respective resource

local procedurallyGeneratedResources = RawResourcesTypesTable.ProcedurallyGenerated
local randomlyGeneratedResources = RawResourcesTypesTable.RandomlyGenerated

Map:RandomlyUpdateFromTag("UsableTile", randomlyGeneratedResources[1], randomlyGeneratedResources[1].ExtraData.FilteredTags)
Map:RandomlyUpdateFromTag("UsableTile", randomlyGeneratedResources[2], procedurallyGeneratedResources[1].ExtraData.FilteredTags ) 

Map:ProcedurallyUpdateFromTag("UsableTile", procedurallyGeneratedResources[1], randomlyGeneratedResources[2].ExtraData.FilteredTags)

-- print(#game:GetService('CollectionService'):GetTagged("UsableTile").. " tiles are usable")
-- Map.DoPrintStatus = true

-------------------- setting resource deposit sizes --------------------
MapGenerationUtilities.SetResourceDepositSize(randomlyGeneratedResources)
MapGenerationUtilities.SetResourceDepositSize(procedurallyGeneratedResources)

-- -------------------- Positioning props/assets on tiles --------------------
task.wait()
Map:PositionInstanceOnTaggedTiles("Iron", randomlyGeneratedResources[1].ExtraData.GameObject, 1, true)
Map:PositionInstanceOnTaggedTiles("Clay", randomlyGeneratedResources[2].ExtraData.GameObject, 1, true)
Map:PositionInstanceOnTaggedTiles("Timber", nil, 1, true)

local cs = game:GetService('CollectionService')

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
local cs = game:GetService('CollectionService')

for _, tile in ipairs(cs:GetTagged("Timber")) do
    local treeGroup = Instance.new("Model")
    treeGroup.Name = "TreeGroup"
    treeGroup.Parent = tile
    for i = 1, 4 do
        PositionInTile(GetProp(props), tile, posTable[i])
    end    

    treeGroup:PivotTo(treeGroup:GetPivot() * CFrame.Angles(0, math.random(0, 360), 0))
end





-- task.wait()
-- Map.Debug.FilterTiles.WhitelistAndGradient(Map, "ResourceAmmount", {

--     procedurallyGeneratedResources[1].ExtraData.Debug,
--     randomlyGeneratedResources[1].ExtraData.Debug,
--     randomlyGeneratedResources[2].ExtraData.Debug,
-- })

--  task.wait()

-- Map.Debug.FilterTiles.Blacklist(Map, {
--     procedurallyGeneratedResources[1].ExtraData.Debug,
--     randomlyGeneratedResources[1].ExtraData.Debug,
--     randomlyGeneratedResources[2].ExtraData.Debug,
-- })


