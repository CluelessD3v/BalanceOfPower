--[[
    this module holds the data that determines how resources will be generated through the map
    Things to note:

    Limit: Sets the utter maximum number of said resource
    Threshold: This sets how a resource is "distributed" across the map, the algorithim cycles through the map from
    LEFT to Right, Top to BOTTOM; so the threshold basically is how likely the tile will be set said info in that iteration.

    Note: You can test that by setting the threshold to 1 and seeing how all resources are groupped in top left of the map.


]]--

return {
    Iron = {

        Threshold = 0.003,
        Tags = {"Iron", "HasResource"},
        FilteredTags = {"Impassable", "HasResource", "WaterBody", "Beach", "Lowland"},
        Debug = {
            Tag = "Iron",
            Color = Color3.fromRGB(89, 34, 89),
            Min = 0,
            Max = 1000
        },

    },

    Timber = {
        Threshold = 0.38,
        Limit = 8000,
        Tags = {"Timber", "HasResource"},
        FilteredTags = {"Impassable", "HasResource", "WaterBody", "Beach"},
        Debug = {
            Tag = "Timber",
            Color = Color3.fromRGB(0, 255, 0),
            Min = 0,
            Max = 1000
        },
        
    },

    Clay = {
        Threshold = 0.006,
        Tags = {"Clay", "HasResource"},
        FilteredTags = {"Impassable", "HasResource", "WaterBody", "Beach", "Mountainous", "Steepland"},
        Debug = {
            Tag = "Clay",
            Color = Color3.fromRGB(255, 89, 89),
            Min = 0,
            Max = 1000
        },
    },

}