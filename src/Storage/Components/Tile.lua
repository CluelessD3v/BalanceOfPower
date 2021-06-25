local ReplicatedStorage = game:GetService('ReplicatedStorage')
local CustomInstance = require(ReplicatedStorage.Utilities.CustomInstance)


local Tile = {} 
Tile.__index = Tile

function Tile.new()
    local self = setmetatable({}, Tile)
    self.Asset  = CustomInstance.new("Part", {
        Properties = {
            Anchored = true,
            Material = Enum.Material.SmoothPlastic,
            BrickColor = BrickColor.new("Really red"),
        },
        Tags = {
            "Tile",
        }
    })

    return self
end
    

return Tile