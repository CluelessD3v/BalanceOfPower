local GenerateProps = {}


--//TODO put all of this with the tile class in the future

--[[
    this places N number of assets allong the tile
    
    x   o   x -- representation of a tile, each X is an asset
    o   x   o -- specially good for trees and pebbles
    x   x   o
    o   x   x

    NOTE: this function will respect the boundaries of the tile INDEPENDENTLY of the asset size.
]]--


function GenerateProps.InstanceAcrossTile(aTile: BasePart, taggedpropList: table, aChance: integer, hasRandomOrientation: boolean)
    for x = 1, aTile.Size.X do
        for z = 1, aTile.Size.Z do
            local chance = math.floor(Random.new():NextNumber(1, 100))
            if chance <= aChance then


                local prop = taggedpropList[math.random(1, #taggedpropList)]:Clone()
                prop.Size = Vector3.new(aTile.Size.X * .1, aTile.Size.Y * .2 , aTile.Size.Z * .1 )

                if hasRandomOrientation then
                    prop.Orientation = Vector3.new(0, math.random(0, 360),0)
                end
                
                    
                local xOffset = x * prop.Size.X - aTile.Size.X/2
                local zOffset =  z * prop.Size.Z  - aTile.Size.Z/2
                local yOffset =  aTile.Size.Y/2 + prop.Size.Y/2
                
                prop.Position = aTile.Position + Vector3.new(xOffset, yOffset, zOffset)
                prop.Parent = aTile
             end
         end
     end


end


--[[ 
    tHIS PLACES AN ASSET EXACTLY IN THE MIDLE OF TILE + Y offset 
            I
            I            
            I-- TREE ASSET EXAMPLE
    ----------------------
    ----------------------
                specially good for grass and big rocks
--]]

function GenerateProps.InstanceToOrigin(taggedTilesList: table, taggedpropList: table, aChance: integer, hasRandomOrientation: boolean)
    for _, tile in ipairs(taggedTilesList) do

        local chance = Random.new():NextNumber(0, 1)
        if chance <= aChance then
            local prop = taggedpropList[math.random(1, #taggedpropList)]:Clone()
            
            if hasRandomOrientation then
                prop.Orientation = Vector3.new(0, math.random(0, 360),0)
            end

            prop.Size = Vector3.new(tile.Size.X, prop.Size.Y, tile.Size.Z)
            
            local yOffset =  tile.Size.Y/2 + prop.Size.Y/2
            prop.Position = tile.Position + Vector3.new(0, yOffset, 0)
            prop.Parent = tile
        end
    end
end


return GenerateProps