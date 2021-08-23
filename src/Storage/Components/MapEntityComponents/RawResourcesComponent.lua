--[[
    this module holds the data that determines how resources will be generated through the map
    Things to note:

    Limit: Sets the utter maximum number of said resource
    Threshold: This sets how a resource is "distributed" across the map, the algorithim cycles through the map from
    LEFT to Right, Top to BOTTOM; so the threshold basically is how likely the tile will be set said info in that iteration.

    Note: You can test that by setting the threshold to 1 and seeing how all resources are groupped in top left of the map.


]]--

-->//TODO Fixcon2 Include the debug table into the Extra data bit
return {
    Iron = {

        Tags = {"Iron", "HasResource"},
        ExtraData = {
            Threshold = 0.0025,
            FilteredTags = {"Impassable", "HasResource", "WaterBody", "Beach", "Lowland"},
            GameObject = workspace.Props.Iron    
        },

        Debug = {
            Tag = "Iron",
            Color = Color3.fromRGB(89, 34, 89),
            Min = 0,
            Max = 1000
        },

        WeightsData = {
            
            Small = {
                Ammount = {
                    Min = 100,
                    Max = 300
                },
                Weight = 30
            },
        
        Medium  =  {
                Ammount = {
                    Min = 400,
                    Max = 700
                },
                Weight = 60
            },
            
        Large = {
                Ammount = {
                    Min = 800,
                    Max = 1000
                },
                Weight = 10
            },
        }

    },

    Timber = {
        Tags = {"Timber", "HasResource"},
        FilteredTags = {"Impassable", "HasResource", "WaterBody", "Beach", "Mountainous", "Steepland"},
        ExtraData = {
            Threshold = 0.4,
            Limit = 8000,
            GameObject = workspace.Props.EbonyTree1
        },

        Debug = {
            Tag = "Timber",
            Color = Color3.fromRGB(0, 255, 0),
            Min = 0,
            Max = 1000
        },

        WeightsData = {
            Small = {
                Ammount = {
                    Min = 100,
                    Max = 300
                },
                Weight = 30
            },
        
        Medium  =  {
                Ammount = {
                    Min = 400,
                    Max = 700
                },
                Weight = 60
            },
            
        Large = {
                Ammount = {
                    Min = 800,
                    Max = 1000
                },
                Weight = 10
            },
        }
        
    },

    Clay = {
        Tags = {"Clay", "HasResource"},
        FilteredTags = {"Impassable", "HasResource", "WaterBody", "Beach", "Mountainous", "Steepland"},
        ExtraData = {
            Threshold = 0.0035,
        },
        Debug = {
            Tag = "Clay",
            Color = Color3.fromRGB(255, 89, 89),
            Min = 0,
            Max = 1000
        },

        WeightsData = {
            Small = {
                Ammount = {
                    Min = 100,
                    Max = 300
                },
                Weight = 30
            },
        
        Medium  =  {
                Ammount = {
                    Min = 400,
                    Max = 700
                },
                Weight = 60
            },
            
        Large = {
                Ammount = {
                    Min = 800,
                    Max = 1000
                },
                Weight = 10
            },
        }
    },

}