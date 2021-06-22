

local CollectionService = game:GetService('CollectionService')

local TerrainGenerator = {}

function TerrainGenerator.GenerateForest(theForestTilesList: table)
    local treeList = CollectionService:GetTagged("Tree")
    for _, tile in ipairs(theForestTilesList) do
        for i = 1, tile.Size.X do
            for j = 1, tile.Size.Z do
                local chance = Random.new():NextNumber(0, 1)
                    
                if chance >= .96 then
                    local pine = treeList[math.random(1, #treeList)]:Clone()
                    pine.Name = "Pine"..i..","..j

                    -- since it
                    local xOffset = i * pine.Size.X/pine.Size.X - tile.Size.X/2
                    local zOffset = j * pine.Size.Z/pine.Size.Z  - tile.Size.Z/2
                    local yOffset =  tile.Size.Y/2 + pine.Size.Y/2
                    pine.Position = tile.Position + Vector3.new(xOffset, yOffset, zOffset)
                    pine.Orientation = Vector3.new(0, math.random(0, 360),0)
                    pine.Parent = tile    
                end
            end
        end

    end

    print("Forest Generated")
end


function TerrainGenerator.GenerateGrass(thePlainsTilesList)
    local grassList = CollectionService:GetTagged("Grass")
    
    for _, tile in ipairs(thePlainsTilesList) do
        local grass = grassList[math.random(1, #grassList)]:Clone()
        grass.Name = "Grass"
        grass.Size = Vector3.new(tile.Size.X-2, .5, tile.Size.Z-2)
        local chance = Random.new():NextNumber(0, 1)
        
        if chance >= .75 then
            local yOffset =  tile.Size.Y/2 + grass.Size.Y/2
            grass.Position = tile.Position + Vector3.new(0, yOffset, 0)
            grass.Orientation = Vector3.new(0, math.random(0, 360),0)
            grass.Parent = tile
        end
    end
    print("Grass Generated")
end




return TerrainGenerator