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
                AllowedTags = {"UseableTile"},
                FilteredTags = {"Beach"}
            }
    
        },

        [2] = {
            Properties = {},
            Tags = {"BuildingAsset"},
            Attributes = {},
            ExtraData = {
                GameObject = workspace.Yellow,
                AllowedTags = {"Iron"},
                FilteredTags = {}
            }
    
        },

        [3] = {
            Properties = {},
            Tags = {"BuildingAsset"},
            Attributes = {},
            ExtraData = {
                GameObject = workspace.Blue,
                AllowedTags = {"Clay"},
                FilteredTags = {},
            }
    
        },

        [4] = {
            Properties = {},
            Tags = {"BuildingAsset"},
            Attributes = {},
            ExtraData = {
                GameObject = workspace.Green,
                AllowedTags = {"Timber"},
                FilteredTags = {},
            }
    
        },
    }
}