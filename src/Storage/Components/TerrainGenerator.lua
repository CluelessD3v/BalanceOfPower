

local CollectionService = game:GetService('CollectionService')

local TerrainGenerator = {}

function TerrainGenerator.GenerateForest(theForestTilesList: table)
    local terrainAssets = CollectionService:GetTagged("TerrainAsset")

    for index, tile in ipairs(theForestTilesList) do
        for i = 1, tile.Size.X do
            for j = 1, tile.Size.Y do
                local chance = Random.new():NextNumber(0, 1)
                    
                if chance >= .95 then
                    local pine = terrainAssets[1]:Clone()
                    local Xpos = i * pine.PrimaryPart.Size.X 
                    local Zpos = j * pine.PrimaryPart.Size.Z 
                    pine:SetPrimaryPartCFrame(CFrame.new(tile.Position + Vector3.new(Xpos, pine.PrimaryPart.Size.Y/2, Zpos ) +  Vector3.new(0, tile.Size.Y/2, 0)))
                    pine.Parent = tile 
                end   
            end
        end
        if index%10 == 0 then wait() end
    end

    print("Forest Generated")
end




return TerrainGenerator