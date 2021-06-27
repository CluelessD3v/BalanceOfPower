
local PerlinNoise = require(script.Parent.PerlinNoise)
local CollectionService = game:GetService('CollectionService')

local FeatureGenerator = {}

function FeatureGenerator.GenerateForest(aTile, theForestTilesList: table)
    local treeList = CollectionService:GetTagged("Tree")
    for _, tile in ipairs(theForestTilesList) do
        aTile.Asset = tile

        for i = 1, tile.Size.X do
            for j = 1, tile.Size.Z do
                local chance = Random.new():NextNumber(0, 1)

                if chance >= .96 then
                    local pine = treeList[math.random(1, #treeList)]:Clone()
                    pine.Name = "Pine"..i..","..j
                    aTile:PlaceWithin(pine, i, j, true)
                end
            end
        end

    end

    print("Forest Generated")
end


function FeatureGenerator.GenerateMountains(aTile, theMountainsTileList)
    local scale = .5

    for i, tile in ipairs(theMountainsTileList) do
        aTile.Asset = tile

        --//TODO check into using fractal browning motion, as depicted here https://thebookofshaders.com/13/
        
        local noiseResult = PerlinNoise.new({i  * scale,  i * scale, 0}, 10, 6, .4)
        noiseResult = math.clamp(noiseResult + .5, 0, .5)
        if noiseResult < .4 then
            tile.Position = tile.Position + Vector3.new(0,2,0)
        elseif noiseResult <=5 then
            tile.Position = tile.Position + Vector3.new(0, 4, 0)
        end
            
    end
end

function FeatureGenerator.GenerateGrass(aTile, thePlainsTilesList)
    local grassList = CollectionService:GetTagged("Grass")
    
    for _, tile in ipairs(thePlainsTilesList) do
        aTile.Asset = tile

        local grass = grassList[math.random(1, #grassList)]:Clone()
        grass.Name = "Grass"
        grass.Size = Vector3.new(tile.Size.X-1, .5, tile.Size.Z-1)
        local chance = Random.new():NextNumber(0, 1)
        
        if chance >= .75 then
            aTile:PlaceOnTop(grass, true)    
        end
    end
    print("Grass Generated")
end




return FeatureGenerator