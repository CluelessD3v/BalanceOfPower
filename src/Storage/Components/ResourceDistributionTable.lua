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
        
        LowlandIron = {
            Limit  = 20,
            Threshold = 0.01,
            Tags = {"Iron", "HasResource"}
        },
    
        UplandIron = {
            Limit  = 20,
            Threshold = 0.01,
            Tags = {"Iron", "HasResource"}
        },
        HighlandIron = {
            Limit  = 30,
            Threshold = 0.01,
            Tags = {"Iron", "HasResource"}
        },
        SteeplandIron = {
            Limit  = 40,
            Threshold = 0.01,
            Tags = {"Iron", "HasResource"}
        },
        MountainousIron = {
            Limit  = 50,
            Threshold = 0.01,
            Tags = {"Iron", "HasResource"}
        },
    }

}