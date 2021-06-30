local ReplicatedStorage = game:GetService('ReplicatedStorage')
local CollectionService = game:GetService('CollectionService')

local PerlinNoise = require(script.Parent.PerlinNoise)
local FallOffMap = require(script.FallOffMap)
local TileMetadata = require(script.TileMetadata)

local Map = {} 


Map.__index = Map

function Map.new(mapGenConfigTable, theTerrainTypesMap: table, aTile: BasePart)    
    assert(aTile, "Tile argument was missing, pass a Basepart!")
    local self = setmetatable({}, Map)
    
    -- Reads from config values and then sets the data to it’s mapped field

    -- note: These only happen if map gen is "random" these are the best range of values I tested.
    if mapGenConfigTable.DoRandomMapGeneration then
        mapGenConfigTable.Seed = math.random(-64000, 64000)
        mapGenConfigTable.Amplitude = math.random(24, 28)
        mapGenConfigTable.Persistence = Random.new():NextNumber(.48, .52 )
        mapGenConfigTable.Octaves = math.random(6, 9)
        mapGenConfigTable.Scale = Random.new():NextNumber(.48, .53)
        

        mapGenConfigTable.FallOffOffset = math.random(9,11) 
        mapGenConfigTable.FallOffSmoothness = math.random(9,11)
    end
    
    if mapGenConfigTable.Seed == 0 then
        mapGenConfigTable.Seed = math.random(-100000, 100000)
    end

    -- map config to variables
    self.MapSize = math.clamp(mapGenConfigTable.MapSize, 4, 512)
    self.TileSize = math.clamp(mapGenConfigTable.TileSize, 1, 100)

    local seed = math.clamp(mapGenConfigTable.Seed, -100000, 100000)
    local amplitude =  math.clamp(mapGenConfigTable.Amplitude, 1, 100)
    local scale =  math.clamp(mapGenConfigTable.Scale, .1, 1)
    local octaves =  math.clamp(mapGenConfigTable.Octaves, 1, 10)
    local persistence =  math.clamp(mapGenConfigTable.Persistence, .1, 1)

    local fallOffOffset =  math.clamp(mapGenConfigTable.FallOffOffset, 1, 15)
    local fallOffSmoothness =  math.clamp(mapGenConfigTable.FallOffSmoothness, 1, 15)
    local filterType = math.clamp(mapGenConfigTable.FilterType, 0, 2)

    local DoGenerateColorMap = mapGenConfigTable.DoGenerateColorMap
    --Map generation    
    for i = 1, self.MapSize do
        for j = 1, self.MapSize do
            -- Noise and fall off calculations
            local noiseResult  = PerlinNoise.new({(i + seed) * scale, (j + seed) * scale}, amplitude, octaves, persistence)
            local fallOff = nil

            -- Check which filter to use
            if filterType == 1 then
                fallOff = FallOffMap.GenerateSquareFallOff(i, j , self.MapSize)
            elseif filterType == 2 then
                fallOff = FallOffMap.GenerateRadialFallOff(i, j , self.MapSize)
            else
                fallOff = 0
            end

            noiseResult  -= FallOffMap.Transform(fallOff, fallOffOffset, fallOffSmoothness)
            noiseResult  = math.clamp(noiseResult +.5  , 0, 1)

            local tile = aTile:Clone()
            tile.Size = Vector3.new(self.TileSize, self.TileSize, self.TileSize)
            tile.Position = Vector3.new(i * tile.Size.X, tile.Size.Y, j * tile.Size.Z)
            tile.Name = i..","..j

            tile.Color = Color3.new(noiseResult , noiseResult , noiseResult )
            TileMetadata.SetMetadata(noiseResult , tile, theTerrainTypesMap, DoGenerateColorMap)
            
    
            tile.Parent = workspace 
        end
    end
    
    return self
end


return Map


















