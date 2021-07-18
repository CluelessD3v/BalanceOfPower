--[[
    the mapping method to set tile metadata based on the given terrain type table WILL NOT REACH THE LAST VALUE, add a place holder one at the end, e.g:
    tab = {1, 2, 3, 4, 5, 6} <- place holder value
                       ^ penultimate value is the actual LAST!

    --]]
return {
    {
        Properties = {
            BrickColor = BrickColor.new("Bright blue")
        },
        Attributes = {
            TerrainThreshold = 0,
            ElevationOffset = 2,
            HasResource = false,
            ResourceAmmount = 0,

        },

        Tags = {
            TerrainType = "Ocean",
            Resource = "None",
            Feature = "None",            
        },

        Descriptors = {
            "WaterBody",
        }
    },

    {
        Properties = {
            BrickColor = BrickColor.new("Electric blue"),
        },

        Attributes = {
            TerrainThreshold = .2,
            ElevationOffset = 2,
            HasResource = false,
            ResourceAmmount = 0,

        },

        Tags = {
            TerrainType = "Littoral",
            Resource = "None",
            Feature = "None",            
        },

        Descriptors = {
            "WaterBody",
        }
    },

    {
        Properties = {
            BrickColor = BrickColor.new("Cyan"),
        },

        Attributes = {
            TerrainThreshold = .45,
            ElevationOffset = 2,
            HasResource = false,
            ResourceAmmount = 0,

        },

        Tags = {
            TerrainType = "Coastal",
            Resource = "None",
            Feature = "None",            
        },

        Descriptors = {
            "WaterBody",
        }
    },

    {
        Properties = {
            BrickColor = BrickColor.new("Daisy orange"),
        },

        Attributes = {
            TerrainThreshold = .545,
            ElevationOffset = 4,
            HasResource = false,
            ResourceAmmount = 0,

        },

        Tags = {
            TerrainType = "Beach",
            Resource = "None",
            Feature = "None",            
        },

        Descriptors = {}
    },

    {
        Properties = {
            BrickColor = BrickColor.new("Moss"),
        },

        Attributes = {
            TerrainThreshold = .6,
            ElevationOffset = 4,
            HasResource = false,
            ResourceAmmount = 0,

        },

        Tags = {
            TerrainType = "Lowland",
            Resource = "None",
            Feature = "None",            
        },

        Descriptors = {}
    },

    {
        Properties = {
            BrickColor = BrickColor.new("Bright green"),
        },

        Attributes = {
            TerrainThreshold = .7,
            ElevationOffset = 5,
            HasResource = false,
            ResourceAmmount = 0,

        },

        Tags = {
            TerrainType = "Upland",
            Resource = "None",
            Feature = "None",            
        },

        Descriptors = {}
    },


    {
        Properties = {
            BrickColor = BrickColor.new("Sea green"),
        },

        Attributes = {
            TerrainThreshold = .8,
            ElevationOffset = 6,
            HasResource = false,
            ResourceAmmount = 0,

        },

        Tags = {
            TerrainType = "Highland",
            Resource = "None",
            Feature = "None",            
        },

        Descriptors = {}
    },


    {
        Properties = {
            BrickColor = BrickColor.new("Dark green"),
        },

        Attributes = {
            TerrainThreshold = .9,
            ElevationOffset = 7,
            HasResource = false,
            ResourceAmmount = 0,

        },

        Tags = {
            TerrainType = "Steepland",
            Resource = "None",
            Feature = "None",            
        },

        Descriptors = {}
    },


    {
        Properties = {
            BrickColor = BrickColor.new("Slime green"),
        },

        Attributes = {
            TerrainThreshold = .99,
            ElevationOffset = 8,
            HasResource = false,
            ResourceAmmount = 0,

        },

        Tags = {
            TerrainType = "Mountainous",
            Resource = "None",
            Feature = "None",            
        },

        Descriptors = {}
    },
    
    {
        Properties = {},

        Attributes = { --place holder val
            TerrainThreshold = 1
        },
        Tags = {},
        Descriptors = {}
    }


}