-- Services
local CollectionService = game:GetService('CollectionService')
local ReplicatedStorage = game:GetService('ReplicatedStorage')

-- Classes
local MapClass = require(game:GetService('ServerStorage').Components.Map)
local FeatureGenerator = require(game:GetService('ServerStorage').Components.FeatureGenerator)
local TileClass = require(game:GetService('ServerStorage').Components.Tile)

-- Mapping MapGenerationConfig values to the map gen table
local mapGenFolder = ReplicatedStorage.Configuration.MapGenerationConfig
local mapGenerationTable = {}
mapGenerationTable.MapSize = mapGenFolder.MapSize.Value
mapGenerationTable.TileSize = mapGenFolder.TileSize.Value
mapGenerationTable.DoRandomMapGeneration = mapGenFolder.DoRandomMapGeneration.Value
mapGenerationTable.DoGenerateColorMap = mapGenFolder.DoGenerateColorMap.Value
mapGenerationTable.Seed = mapGenFolder.Seed.Value
mapGenerationTable.Scale = mapGenFolder.Scale.Value
mapGenerationTable.Amplitude = mapGenFolder.Amplitude.Value
mapGenerationTable.Octaves = mapGenFolder.Octaves.Value
mapGenerationTable.Persistence = mapGenFolder.Persistence.Value
mapGenerationTable.FallOffOffset = mapGenFolder.FallOffOffset.Value
mapGenerationTable.FallOffSmoothness = mapGenFolder.FallOffSmoothness.Value
mapGenerationTable.FilterType = mapGenFolder.FilterType.Value


local ResourcesTable = {
    Lumber = {
        
    },

}


--[[
    the mapping method to set tile metadata based on the given terrain type table WILL NOT REACH THE LAST VALUE, add a place holder one at the end, e.g:
    tab = {1, 2, 3, 4, 5, nil} <- place holder value
                       ^ penultimate value is the actual LAST!

    --]]
local terrainTypesTable = {
    {
        TerrainThreshold = 0,
        ElevationOffset = 2,
        ElevationTag = "None",
        TerrainColor = BrickColor.new("Bright blue"),
        TerrainTags = {"Ocean", "WaterBody"},

    },
    {
        TerrainThreshold = .35,
        ElevationOffset = 2,
        ElevationTag = "None",
        TerrainColor = BrickColor.new("Cyan"),
        TerrainTags = {"Littoral", "WaterBody"},
    },
    {
        TerrainThreshold = .465,
        ElevationOffset = 4,
        ElevationTag = "Flat",
        TerrainColor = BrickColor.new("Daisy orange"),
        TerrainTags = {"Beach"}

    },

    {
        TerrainThreshold = .52,
        ElevationOffset = 4,
        ElevationTag = "Flat",
        TerrainColor = BrickColor.new("Bright green"),
        TerrainTags = {"Green", "Plain"},
    },

    {
        TerrainThreshold = .7,
        ElevationOffset = 6,
        ElevationTag = "Mound",
        TerrainColor = BrickColor.new("Sea green"),
        TerrainTags = {"Green", "Plain", "Forest"},
    },

    
    {
        TerrainThreshold = .8,
        ElevationOffset = 8,
        ElevationTag = "Hilly",
        TerrainColor = BrickColor.new("Dark green"),
        TerrainTags = {"Green"},
    },

    {
        TerrainThreshold = .9,
        ElevationOffset = 10,
        ElevationTag = "Mountainous",
        TerrainColor = BrickColor.new("Slime green"),
        TerrainTags = {"Green"},
        PropsTags = {"Pebles", "Branches", "Grass"}
    },


    {
        TerrainThreshold = .99,
        ElevationOffset = 16,
        ElevationTag = "ExtremelyMountainous",
        TerrainColor = BrickColor.new("Dark stone grey"),
        TerrainTags = {"Impassable"},

    },
    {
        TerrainThreshold = 1,
    }
}




local Tile = TileClass.new()

local map = MapClass.new(mapGenerationTable, terrainTypesTable, Tile.GameObject)
map:SetMapElevation()
map:GeneratePropsOnTile(Tile, "Plain", "Grass") 
map:GeneratePropsAcrossTile(Tile, "Forest", "Tree")

--//TODO Use a map class method to get certain tiles

--[[if TerrainGenerationConfig.DoGenerateMountains.Value then
    FeatureGenerator.GenerateGrass(Tile, CollectionService:GetTagged("Plain"))
end

if TerrainGenerationConfig.DoGenerateForest.Value then
    FeatureGenerator.GenerateMountains(Tile, CollectionService:GetTagged("Mountain"))
end

--//TODO TEMPORAL, FOREST STORE LUMBER RESOURCE!
if TerrainGenerationConfig.DoGenerateGrass.Value then
    FeatureGenerator.GenerateForest(Tile, CollectionService:GetTagged("Forest"))
end

--]]

