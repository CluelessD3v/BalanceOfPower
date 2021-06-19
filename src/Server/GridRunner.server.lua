local Map = require(game:GetService('ServerStorage').Components.MapGenerator)
local NormalizeValue = require(game:GetService('ReplicatedStorage').Utilities.NormalizeValue)


local mapGenFieldMap  = {}

mapGenFieldMap.MapSize = math.clamp(script:GetAttribute("MapSize"), 32, 512)
mapGenFieldMap.TileSize = math.clamp(script:GetAttribute("TileSize"), 1, 100)
mapGenFieldMap.Seed = math.clamp(script:GetAttribute("Seed"), -32768, 32768)

--[[mapGenFieldMap.Amplitude = math.clamp(script:GetAttribute("Amplitude"), 1, 100)
mapGenFieldMap.Scale = math.clamp(script:GetAttribute("Scale"), .1, 1)
mapGenFieldMap.Octaves = math.clamp(script:GetAttribute("Octaves"), 1, 100)
mapGenFieldMap.Persistence = math.clamp(script:GetAttribute("Persistence"), .01, 1)

mapGenFieldMap.FallOffOffset = math.clamp(script:GetAttribute("FallOffOffset"), 1, 12)
mapGenFieldMap.FallOffPower = math.clamp(script:GetAttribute("FallOffPower"), 1, 12)--]]
--]]

mapGenFieldMap.FallOffOffset = math.random(5,9) 
mapGenFieldMap.FallOffPower = math.random(5,9)

mapGenFieldMap.Amplitude = math.random(20, 30)
mapGenFieldMap.Persistence = Random.new():NextNumber(.48, .52 )
mapGenFieldMap.Octaves = math.random(6, 9)
mapGenFieldMap.Scale =Random.new():NextNumber(.46, .53)



if script:GetAttribute("Seed") == 0 then
    mapGenFieldMap.Seed = math.random(-32768, 32768)
end

print(mapGenFieldMap)

Map.new(mapGenFieldMap)


