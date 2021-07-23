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
        Debug = {
            Tag = "Iron",
            Color = Color3.fromRGB(89, 34, 89),
            Min = 0,
            Max = 1000
        },
        
        LowlandIron = {
            Limit  = 5,
            Threshold = 0.01,
            Tags = {"Iron", "HasResource"}
        },
    
        UplandIron = {
            Limit  = 5,
            Threshold = 0.01,
            Tags = {"Iron", "HasResource"}
        },
        HighlandIron = {
            Limit  = 5,
            Threshold = 0.01,
            Tags = {"Iron", "HasResource"}
        },
        SteeplandIron = {
            Limit  = 5,
            Threshold = 0.2,
            Tags = {"Iron", "HasResource"}
        },
        MountainousIron = {
            Limit  = 10,
            Threshold = 0.03,
            Tags = {"Iron", "HasResource"}
        },
    },

    Timber = {

        Debug = {
            Tag = "Timber",
            Color = Color3.fromRGB(0, 255, 0),
            Min = 0,
            Max = 1000
        },
        
        LowlandTimber = {
            Limit  = 1000,
            Threshold = 0.3,
            Tags = {"Timber", "HasResource"}
        },
    
        UplandTimber = {
            Limit  = 1000,
            Threshold = 0.3,
            Tags = {"Timber", "HasResource"}
        },
        HighlandTimber = {
            Limit  = 500,
            Threshold = 0.2,
            Tags = {"Timber", "HasResource"}
        },
        SteeplandTimber = {
            Limit  = 500,
            Threshold = 0.1,
            Tags = {"Timber", "HasResource"}
        },
        MountainousTimber = {
            Limit  = 500,
            Threshold = 0.1,
            Tags = {"Timber", "HasResource"}
        },
    },

    Clay = {
        Debug = {
            Tag = "Clay",
            Color = Color3.fromRGB(255, 89, 89),
            Min = 0,
            Max = 1000
        },
        
        LowlandClaw = {
            Limit  = 20,
            Threshold = 0.01,
            Tags = {"Clay", "HasResource"}
        },
    
        UplandClay = {
            Limit  = 15,
            Threshold = 0.020,
            Tags = {"Clay", "HasResource"}
        },
        HighlandClay = {
            Limit  = 10,
            Threshold = 0.01,
            Tags = {"Clay", "HasResource"}
        },
    },

}