--[[
    the mapping method to set tile metadata based on the given terrain type table WILL NOT REACH THE LAST VALUE, add a place holder one at the end, e.g:
    tab = {1, 2, 3, 4, 5, 6} <- place holder value
                       ^ penultimate value is the actual LAST!

    --]]
return {
    {
        Attributes = {
            TerrainThreshold = 0,
            ElevationOffset = 2,
            TerrainColor = BrickColor.new("Bright blue"),
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
        Attributes = {
            TerrainThreshold = .25,
            ElevationOffset = 2,
            TerrainColor = BrickColor.new("Electric blue"),
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
        Attributes = {
            TerrainThreshold = .4,
            ElevationOffset = 2,
            TerrainColor = BrickColor.new("Cyan"),
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
        Attributes = { --place holder val
            TerrainThreshold = 1
        },
    }


}