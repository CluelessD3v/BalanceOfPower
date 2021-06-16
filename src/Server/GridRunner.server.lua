local Grid = require(game:GetService('ServerStorage').Components.GridObject)
local CustomInstance = require(game:GetService('ReplicatedStorage').Utilities.CustomInstance)


Grid.new(script:GetAttribute("GridSize"), script:GetAttribute("TileSize"))


