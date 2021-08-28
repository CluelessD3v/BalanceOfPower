--[[
    This component has all the data related to tiles with buildings. NOTE: Tiles are the ones that hold this info, buildings are just
    visual feedback!
]]

return {
    TestAssets = {
        [1] = {
            Properties = {},
            Tags = {"BuildingAsset"},
            Attributes = {},
            ExtraData = {
                GameObject = workspace.Red,
                WhitelistedTags = {"Beach", "Lowland", "Highland", "Upland", "Steepland", "Mountainous"},
            }
    
        },

        [2] = {
            Properties = {},
            Tags = {"BuildingAsset"},
            Attributes = {},
            ExtraData = {
                GameObject = workspace.Yellow,
                WhitelistedTags = {"Iron"},
            }
    
        },

        [3] = {
            Properties = {},
            Tags = {"BuildingAsset"},
            Attributes = {},
            ExtraData = {
                GameObject = workspace.Blue,
                WhitelistedTags = {"Clay"},
            }
    
        },

        [4] = {
            Properties = {},
            Tags = {"BuildingAsset"},
            Attributes = {},
            ExtraData = {
                GameObject = workspace.Green,
                WhitelistedTags = {"Timber"}
            }
    
        },
    }
}