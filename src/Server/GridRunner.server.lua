local Map = require(game:GetService('ServerStorage').Components.MapGenerator)

local seed  = script:SetAttribute("Seed", math.random(-4096, 4096))


Map.new(script:GetAttribute("GridSize"), script:GetAttribute("TileSize"), script:GetAttribute("Seed") )
