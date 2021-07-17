--[[
    the mapping method to set tile metadata based on the given terrain type table WILL NOT REACH THE LAST VALUE, add a place holder one at the end, e.g:
    tab = {1, 2, 3, 4, 5, 6} <- place holder value
                       ^ penultimate value is the actual LAST!

    --]]
return {
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
        ResourceTag = "",
    },

    {
        TerrainThreshold = .6,
        ElevationOffset = 4,
        TerrainColor = BrickColor.new("Moss"),
        TerrainTag = "Lowland",
        FeatureTag = "",
        ResourceTag = "",
    },

    {
        TerrainThreshold = .7,
        ElevationOffset = 6,
        TerrainColor = BrickColor.new("Bright green"),
        TerrainTag = "Upland",
        FeatureTag = "",
        ResourceTag = "",
    },


    {
        TerrainThreshold = .8,
        ElevationOffset = 8,
        TerrainColor = BrickColor.new("Sea green"),
        TerrainTag = "HighLand",
        FeatureTag = "",
        ResourceTag = "",
    },




    {
        TerrainThreshold = .9,
        ElevationOffset = 10,
        TerrainColor = BrickColor.new("Dark green"),
        TerrainTag = "Steepland",
        FeatureTag = "",
        ResourceTag = "",
    },

    {
        TerrainThreshold = .999,
        ElevationOffset = 12,
        TerrainColor = BrickColor.new("Slime green"),
        TerrainTag = "Mountainous",
        FeatureTag = "",
        ResourceTag ="",
    },

    {
        TerrainThreshold = 1
    }

}   
