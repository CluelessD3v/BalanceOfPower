

local CollectionService = game:GetService('CollectionService')

local TerrainGenerator = {}

function TerrainGenerator.GenerateForest(theForestTilesList: table)
    local treeList = CollectionService:GetTagged("Tree")
    for index, tile in ipairs(theForestTilesList) do
        print(tile.Size)
        for i = 1, tile.Size.X do
            for j = 1, tile.Size.Z do
                local chance = Random.new():NextNumber(0, 1)
                    
                if chance >= .93 then
                    local pine = treeList[math.random(1, #treeList)]:Clone()
                    pine.Name = "Pine"..i..","..j

                    -- since it
                    local xOffset = i * pine.Size.X/2 - tile.Size.X/2  
                    local zOffset = j * pine.Size.Z/2 - tile.Size.Z/2
                    local yOffset =  tile.Size.Y/2 + pine.Size.Y/2
                    local rotation = CFrame.Angles(0, math.rad(math.random(0, 360)), 0)
                    pine.CFrame = CFrame.new(tile.Position + Vector3.new(xOffset, yOffset, zOffset)) * rotation 
                    pine.Parent = tile 
                end   
            end
            
        end
    end

    print("Forest Generated")
end




return TerrainGenerator