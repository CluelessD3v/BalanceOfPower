local MapGenerator = require(game:GetService('ServerStorage').Components.MapGenerator)
local TerrainGenerator = require(game:GetService('ServerStorage').Components.TerrainGenerator)
local CollectionService = game:GetService('CollectionService')

local mapGenFieldMap  = {}

mapGenFieldMap.MapSize = math.clamp(script:GetAttribute("MapSize"), 4, 512)
mapGenFieldMap.TileSize = math.clamp(script:GetAttribute("TileSize"), 1, 100)
mapGenFieldMap.Seed = math.clamp(script:GetAttribute("Seed"), -32768, 32768)

mapGenFieldMap.Amplitude = math.clamp(script:GetAttribute("Amplitude"), 1, 100)
mapGenFieldMap.Scale = math.clamp(script:GetAttribute("Scale"), .1, 1)
mapGenFieldMap.Octaves = math.clamp(script:GetAttribute("Octaves"), 1, 100)
mapGenFieldMap.Persistence = math.clamp(script:GetAttribute("Persistence"), .01, 1)

mapGenFieldMap.FallOffOffset = math.clamp(script:GetAttribute("FallOffOffset"), 1, 12)
mapGenFieldMap.FallOffPower = math.clamp(script:GetAttribute("FallOffPower"), 1, 12)

if script:GetAttribute("Seed") == 0 then
    mapGenFieldMap.Seed = math.random(-32768, 32768)
end


if script:GetAttribute("IsMapGenerationRandom") then 
    mapGenFieldMap.FallOffOffset = math.random(6,9) 
    mapGenFieldMap.FallOffPower = math.random(6,9)

    mapGenFieldMap.Amplitude = math.random(20, 30)
    mapGenFieldMap.Persistence = Random.new():NextNumber(.48, .515 )
    mapGenFieldMap.Octaves = math.random(6, 9)
    mapGenFieldMap.Scale =Random.new():NextNumber(.46, .52)

    for attribute, value in pairs(mapGenFieldMap) do
        script:SetAttribute(attribute, value)
    end
end






local map = MapGenerator.new(mapGenFieldMap)
print("Generating Forest")
wait(1)

if map.Generated then
    TerrainGenerator.GenerateForest(CollectionService:GetTagged("Forest"))
end
--print(mapGenFieldMap)
--print(map)
--print(#CollectionService:GetTagged("Tile"))

