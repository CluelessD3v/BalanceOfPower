--[[
    the mapping method to set tile metadata based on the given terrain type table WILL NOT REACH THE LAST VALUE, add a place holder one at the end, e.g:
    tab = {1, 2, 3, 4, 5, 6} <- place holder value
                       ^ penultimate value is the actual LAST!

    --]]
return {
[1] = {
        Properties = {
            BrickColor = BrickColor.new("Bright blue")
        },
        Attributes = {
            TerrainThreshold = 0,
            ElevationOffset = 3,

        },  
        Tags = {"Ocean"},
},

[2] = {
    Properties = {
        BrickColor = BrickColor.new("Electric blue")
    },
    Attributes = {
        TerrainThreshold = .3,
        ElevationOffset = 3,

    },  
    Tags = {"Littoral"},
},

[3] = {
    Properties = {
        BrickColor = BrickColor.new("Cyan")
    },
    Attributes = {
        TerrainThreshold = .4,
        ElevationOffset = 3,

    },  
    Tags = {"Coastal"},
},


[4] = {
    Properties = {
        BrickColor = BrickColor.new("Daisy orange")
    },
    Attributes = {
        TerrainThreshold = .545,
        ElevationOffset = 4,

    },  
    Tags = {"Beach"},
},

[5] = {
    Properties = {
        BrickColor = BrickColor.new("Moss")
    },
    Attributes = {
        TerrainThreshold = .6,
        ElevationOffset = 4,

    },  
    Tags = {"Lowland"},
},

[6] = {
    Properties = {
        BrickColor = BrickColor.new("Bright green")
    },
    Attributes = {
        TerrainThreshold = .7,
        ElevationOffset = 5,

    },  
    Tags = {"Upland"},
},

[7] = {
    Properties = {
        BrickColor = BrickColor.new("Sea green")
    },
    Attributes = {
        TerrainThreshold = .8,
        ElevationOffset = 6,

    },  
    Tags = {"Highland"},
},

[8] = {
    Properties = {
        BrickColor = BrickColor.new("Dark green")
    },
    Attributes = {
        TerrainThreshold = .9,
        ElevationOffset = 7,

    },  
    Tags = {"Steepland"},
},


[9] = {
    Properties = {
        BrickColor = BrickColor.new("Slime green")
    },
    Attributes = {
        TerrainThreshold = .99,
        ElevationOffset = 8,

    },  
    Tags = {"Mountainous"},
},


    

[10] = {

        Properties = {},
        Attributes = { --place holder val
            TerrainThreshold = 1
        },
        Tags = {},
    },


}