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
            Threshold = 0,
            ElevationOffset = 3,

        },  
        Tags = {"Ocean"},
},

[2] = {
    Properties = {
        BrickColor = BrickColor.new("Electric blue")
    },
    Attributes = {
        Threshold = .3,
        ElevationOffset = 3,

    },  
    Tags = {"Littoral"},
},

[3] = {
    Properties = {
        BrickColor = BrickColor.new("Cyan")
    },
    Attributes = {
        Threshold = .4,
        ElevationOffset = 3,

    },  
    Tags = {"Coastal"},
},


[4] = {
    Properties = {
        BrickColor = BrickColor.new("Daisy orange")
    },
    Attributes = {
        Threshold = .545,
        ElevationOffset = 4,

    },  
    Tags = {"Beach"},
},

[5] = {
    Properties = {
        BrickColor = BrickColor.new("Moss")
    },
    Attributes = {
        Threshold = .6,
        ElevationOffset = 4,

    },  
    Tags = {"Lowland"},
},

[6] = {
    Properties = {
        BrickColor = BrickColor.new("Bright green")
    },
    Attributes = {
        Threshold = .7,
        ElevationOffset = 5,

    },  
    Tags = {"Upland"},
},

[7] = {
    Properties = {
        BrickColor = BrickColor.new("Sea green")
    },
    Attributes = {
        Threshold = .8,
        ElevationOffset = 6,

    },  
    Tags = {"Highland"},
},

[8] = {
    Properties = {
        BrickColor = BrickColor.new("Dark green")
    },
    Attributes = {
        Threshold = .9,
        ElevationOffset = 7,

    },  
    Tags = {"Steepland"},
},


[9] = {
    Properties = {
        BrickColor = BrickColor.new("Slime green")
    },
    Attributes = {
        Threshold = .99,
        ElevationOffset = 8,

    },  
    Tags = {"Mountainous"},
},


    

[10] = {

        Properties = {},
        Attributes = { --place holder val
            Threshold = 1
        },
        Tags = {},
    },


}