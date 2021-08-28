--[[
    the mapping method to set tile metadata based on the given terrain type table WILL NOT REACH THE LAST VALUE, add a place holder one at the end, e.g:
    tab = {1, 2, 3, 4, 5, 6} <- place holder value
                       ^ penultimate value is the actual LAST!

    --]]

--//TODO FIXCON2 Change the colors of the terrain to match those of the delivered color study
return {
    InitialTerrains = {
            [1] = {
                Properties = {
                    BrickColor = BrickColor.new("Bright blue"),
                    Reflectance = .7,
                    CastShadow = false,
                },
                Attributes = {
                    ElevationOffset = 3,
                },

                Tags = {"Ocean", "WaterBody"},

                ExtraData = {
                    Threshold = 0,
                    Limit  = -1,
                }
            },
        
            [2] = {
                Properties = {
                    BrickColor = BrickColor.new("Electric blue"),
                    Reflectance = .7,
                    CastShadow = false,
                },
                Attributes = {
                    ElevationOffset = 3,
        
                },  
                Tags = {"Littoral", "WaterBody"},
                ExtraData = {
                    Threshold = .25,
                    Limit  = -1,
                },
            },
        
            [3] = {
                Properties = {
                    BrickColor = BrickColor.new("Cyan"),
                    Reflectance = .7,
                },
                Attributes = {
                    ElevationOffset = 3,
        
                },  
                Tags = {"Coastal", "WaterBody"},
                ExtraData = {
                    Threshold = .45,
                    Limit  = -1,
                },
            },
        
        
            [4] = {
                Properties = {
                    BrickColor = BrickColor.new("Daisy orange")
                },
                Attributes = {
                    ElevationOffset = 4,
        
                },  
                Tags = {"Beach", "UseableTile"},
                ExtraData = {
                    Threshold = .545,
                    Limit  = -1,
                }
            },
        
            [5] = {
                Properties = {
                    BrickColor = BrickColor.new("Moss")
                },
                Attributes = {
                    ElevationOffset = 4,
        
                },  
                Tags = {"Lowland", "UseableTile"},
                ExtraData = {
                    Threshold = .6,
                    Limit  = -1,
                }
            },
        
            [6] = {
                Properties = {
                    BrickColor = BrickColor.new("Bright green")
                },
                Attributes = {
                    ElevationOffset = 5,
        
                },  
                Tags = {"Upland", "UsableTile"},
                ExtraData = {
                    Threshold = .75,
                    Limit  = -1,
                },
            },
        
            [7] = {
                Properties = {
                    BrickColor = BrickColor.new("Sea green")
                },
                Attributes = {
                    ElevationOffset = 6,
        
                },  
                Tags = {"Highland", "UseableTile"},
                ExtraData = {
                    Threshold = .85,
                    Limit  = -1,
                },
            },
        
            [8] = {
                Properties = {
                    BrickColor = BrickColor.new("Dark green")
                },
                Attributes = {
                    ElevationOffset = 7,
        
                },  
                Tags = {"Steepland", "UseableTile"},
                ExtraData = {
                    Threshold = .95,
                    Limit  = -1,
                },
            },
        
        
            [9] = {
                Properties = {
                    BrickColor = BrickColor.new("Slime green")
                },
                Attributes = {
                    ElevationOffset = 8,
        
                },  
                Tags = {"Mountainous", "UseableTile"},
                ExtraData = {
                    Threshold = .99,
                    Limit  = -1,
                },
            },
        
        
        
            [10] = {
                ExtraData = {
                    Threshold = 1, -- placeholder val
                    Limit  = -1,
                }
            }
},

    StackedTerrains = {
        Impassable = {
            
            Properties = {
                BrickColor = BrickColor.new("Medium stone grey")
            },
            Attributes = {
                ElevationOffset = 10,
            },  
            Tags = {"Impassable"},
            ExtraData = {
                Threshold = .12,
            }
        },
        Depression = {
            Properties = {
                BrickColor = BrickColor.new("Dark green")
            },
            Attributes = {
                ElevationOffset = 7,
            },  
            Tags = {"Steepland", "UseableTile"},
            ExtraData = {
                Threshold = .25
            }
        },

    }
}