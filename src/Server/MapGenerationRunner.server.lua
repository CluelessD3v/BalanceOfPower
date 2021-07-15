-- Services
local CollectionService = game:GetService('CollectionService')
local ReplicatedStorage = game:GetService('ReplicatedStorage')

-- Classes
local MapClass = require(game:GetService('ServerStorage').Components.Map)
local TileClass = require(game:GetService('ServerStorage').Components.Tile)

-- Mapping MapGenerationConfig values to the map gen tbable
local mapGenFolder = ReplicatedStorage.Configuration.MapGenerationConfig
local mapGenerationTable = {}
mapGenerationTable.MapSize = mapGenFolder.MapSize.Value
mapGenerationTable.TileSize = mapGenFolder.TileSize.Value
mapGenerationTable.Seed = mapGenFolder.Seed.Value
mapGenerationTable.Scale = mapGenFolder.Scale.Value
mapGenerationTable.Amplitude = mapGenFolder.Amplitude.Value
mapGenerationTable.Octaves = mapGenFolder.Octaves.Value
mapGenerationTable.Persistence = mapGenFolder.Persistence.Value
mapGenerationTable.FallOffOffset = mapGenFolder.FallOffOffset.Value
mapGenerationTable.FallOffSmoothness = mapGenFolder.FallOffSmoothness.Value
mapGenerationTable.FilterType = mapGenFolder.FilterType.Value

local Map = MapClass.new(mapGenerationTable)




--[[
    the mapping method to set tile metadata based on the given terrain type table WILL NOT REACH THE LAST VALUE, add a place holder one at the end, e.g:
    tab = {1, 2, 3, 4, 5, 6} <- place holder value
                       ^ penultimate value is the actual LAST!

    --]]
local terrainTypesTable = {


    {
        TerrainThreshold = 0,
        ElevationOffset = 2,
        TerrainColor = BrickColor.new("Bright blue"),
        TerrainTag = "Ocean",
        FeatureTag = "",
        ResourceTags = {},
    },

    {
        TerrainThreshold = .25,
        ElevationOffset = 2,
        TerrainColor = BrickColor.new("Electric blue"),
        TerrainTag = "Littoral",
        FeatureTag = "",
        ResourceTags = {},
    },

    {
        TerrainThreshold = .45,
        ElevationOffset = 2,
        TerrainColor = BrickColor.new("Cyan"),
        TerrainTag = "Coast",
        FeatureTag = "",
        ResourceTags = {},
    },

    {
        TerrainThreshold = .545,
        ElevationOffset = 4,
        TerrainColor = BrickColor.new("Daisy orange"),
        TerrainTag = "Beach",
        FeatureTag = "",
        ResourceTags = {},
    },

    {
        TerrainThreshold = .6,
        ElevationOffset = 4,
        TerrainColor = BrickColor.new("Moss"),
        TerrainTag = "Lowland",
        FeatureTag = "",
        ResourceTags = {},
    },

    {
        TerrainThreshold = .7,
        ElevationOffset = 6,
        TerrainColor = BrickColor.new("Bright green"),
        TerrainTag = "Upland",
        FeatureTag = "",
        ResourceTags = {},
    },


    {
        TerrainThreshold = .8,
        ElevationOffset = 8,
        TerrainColor = BrickColor.new("Sea green"),
        TerrainTag = "HighLand",
        FeatureTag = "",
        ResourceTags = {},
    },




    {
        TerrainThreshold = .9,
        ElevationOffset = 10,
        TerrainColor = BrickColor.new("Dark green"),
        TerrainTag = "Steepland",
        FeatureTag = "",
        ResourceTags = {},
    },

    {
        TerrainThreshold = .99,
        ElevationOffset = 12,
        TerrainColor = BrickColor.new("Slime green"),
        TerrainTag = "Mountainous",
        FeatureTag = "",
        ResourceTags = {},
    },

    {
        TerrainThreshold = 1
    }

}   

local Tile = TileClass.new()

Map:GenerateMap(Tile.GameObject, terrainTypesTable)
Map:SetTerrainColor()
Map:SetTerrainElevation()
wait()
Map:TransformTilesFromTag("Mountainous", {
    TerrainThreshold = .1,
    ElevationOffset = 2,
    TerrainColor = BrickColor.new("Medium stone grey"),
    TerrainTag = "Impassable",
})

