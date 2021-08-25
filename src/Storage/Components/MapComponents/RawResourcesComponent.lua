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
    
    RandomlyGenerated = {
        [1] = {
            Tags = {"Iron", "HasResource"},
            
            ExtraData = {
                LookUpTag = "Iron",
                Threshold = 0.003,
                FilteredTags = {"Impassable", "HasResource", "WaterBody", "Beach", "Lowland"},
                GameObject = workspace.Props.Iron,
                
                Debug = {
                    Tag = "Iron",
                    Color = Color3.fromRGB(89, 34, 89),
                    Min = 0,
                    Max = 1000,
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
        },

        [2] = {
            Tags = {"Clay", "HasResource"},

            ExtraData = {
                LookUpTag = "Clay",
                FilteredTags = {"Impassable", "HasResource", "WaterBody", "Beach", "Mountainous", "Steepland"},
                Threshold = 0.004,
                GameObject = workspace.Props.Clay,

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
    },
    ProcedurallyGenerated = {
        {
            Tags = {"Timber", "HasResource"},
            ExtraData = {
                FilteredTags = {"Impassable", "HasResource", "WaterBody", "Beach", "Mountainous", "Steepland"},
                Threshold = 0.45,
                Limit = 8000,
                
                LookUpTag = "Timber",
                
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
        },
    }
}