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
    

--[[ 
    tHIS PLACES AN ASSET EXACTLY IN THE MIDLE OF TILE + Y offset 

            |\
            |\  -- TREE ASSET EXAMPLE
    ----------------------
    ----------------------
                specially good for grass and big rocks
--]]
function Tile:PlaceOnTop(aGameOBject, hasRandomOrientation: boolean)
    local tile = self.Asset     
    if hasRandomOrientation then
        aGameOBject.Orientation = Vector3.new(0, math.random(0, 360),0)
    end

    local yOffset =  tile.Size.Y/2 + aGameOBject.Size.Y/2
    aGameOBject.Position = tile.Position + Vector3.new(0, yOffset, 0)
    aGameOBject.Parent = tile
end


--[[
    this places N number of assets allong the tile
    
    x   o   x -- representation of a tile, each X is an asset, this is nice 
    o   x   o -- specially good for trees and pebbles
    x   x   o
    o   x   x

    NOTE: this function will respect the boundaries of the tile INDEPENDENTLY of the asset size.
]]--

function Tile:PlaceWithin(aGameObject, xOffsetFactor, zOffsetFactor, hasRandomOrientation: boolean)
    local tile = self.Asset

    if hasRandomOrientation then
        aGameObject.Orientation = Vector3.new(0, math.random(0, 360),0)
    end

    
    local xOffset = xOffsetFactor * aGameObject.Size.X/aGameObject.Size.X - tile.Size.X/2
    local zOffset = zOffsetFactor * aGameObject.Size.Z/aGameObject.Size.Z  - tile.Size.Z/2
    local yOffset =  tile.Size.Y/2 + aGameObject.Size.Y/2

    aGameObject.Position = tile.Position + Vector3.new(xOffset, yOffset, zOffset)
    aGameObject.Parent = tile

end
return Tile