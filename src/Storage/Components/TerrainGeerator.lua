

local CollectionService = game:GetService('CollectionService')

local TerrainGenerator = {}

function TerrainGenerator.SpawnTerrainAsset(aTile: Instance)
    local terrainAssets = CollectionService:GetTagged("TerrainAsset")
    if aTile:GetAttribute("TerrainType") == "Forest" then
        
        for i = 1, aTile.Size.X do
            for j = 1, aTile.Size.Y do
                local chance = Random.new():NextNumber(0, 1)
                if chance >= .95 then
                    local pine = terrainAssets[1]:Clone()
                    local Xpos = i * pine.PrimaryPart.Size.X 
                    local Zpos = j * pine.PrimaryPart.Size.Z 
                    pine:SetPrimaryPartCFrame(CFrame.new(aTile.Position + Vector3.new(Xpos, pine.PrimaryPart.Size.Y/2, Zpos ) +  Vector3.new(0, aTile.Size.Y/2, 0)))
                    pine.Parent = aTile 
                end   
            end
        end
    end
end




return TerrainGenerator