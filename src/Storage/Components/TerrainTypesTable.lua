--[[
    the mapping method to set tile metadata based on the given terrain type table WILL NOT REACH THE LAST VALUE, add a place holder one at the end, e.g:
    tab = {1, 2, 3, 4, 5, 6} <- place holder value
                       ^ penultimate value is the actual LAST!

    --]]
return {
    [1] = {
        Threshold = 0,

        Properties = {
            BrickColor = BrickColor.new("Bright blue")
        },
        Attributes = {
        ElevationOffset = 3,

        },  
        Tags = {"Ocean"},
    },

    [2] = {
        Threshold = .3,
        Properties = {
            BrickColor = BrickColor.new("Electric blue")
        },
        Attributes = {
            ElevationOffset = 3,

        },  
        Tags = {"Littoral"},
    },

    [3] = {
        Threshold = .4,
        Properties = {
            BrickColor = BrickColor.new("Cyan")
        },
        Attributes = {
            ElevationOffset = 3,

        },  
        Tags = {"Coastal"},
    },


    [4] = {
        Threshold = .545,
        Properties = {
            BrickColor = BrickColor.new("Daisy orange")
        },
        Attributes = {
            ElevationOffset = 4,

        },  
        Tags = {"Beach"},
    },

    [5] = {
        Threshold = .6,
        Properties = {
            BrickColor = BrickColor.new("Moss")
        },
        Attributes = {
            ElevationOffset = 4,

        },  
        Tags = {"Lowland"},
    },

    [6] = {
        Threshold = .7,
        Properties = {
            BrickColor = BrickColor.new("Bright green")
        },
        Attributes = {
            ElevationOffset = 5,

        },  
        Tags = {"Upland"},
    },

    [7] = {
        Threshold = .8,
        Properties = {
            BrickColor = BrickColor.new("Sea green")
        },
        Attributes = {
            ElevationOffset = 6,

        },  
        Tags = {"Highland"},
    },

    [8] = {
        Threshold = .9,
        Properties = {
            BrickColor = BrickColor.new("Dark green")
        },
        Attributes = {
            ElevationOffset = 7,

        },  
        Tags = {"Steepland"},
    },


    [9] = {
        Threshold = .99,
        Properties = {
            BrickColor = BrickColor.new("Slime green")
        },
        Attributes = {
            ElevationOffset = 8,

        },  
        Tags = {"Mountainous"},
    },



    [10] = {
        Threshold = 1 -- placeholder val

    }
}