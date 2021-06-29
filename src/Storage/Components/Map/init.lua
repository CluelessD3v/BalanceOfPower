local ReplicatedStorage = game:GetService('ReplicatedStorage')
local CollectionService = game:GetService('CollectionService')

local PerlinNoise = require(script.Parent.PerlinNoise)
local FallOffMap = require(script.FallOffMap)
local ColorMap = require(script.ColorMap)
local TileMetadata = require(script.TileMetadata)

local Map = {} 


Map.__index = Map

function Map.new(theTerrainTypesMap: table, aTile: BasePart)    
    local mapGenConfig = ReplicatedStorage.Configuration.MapGenerationConfig
    local self = setmetatable({}, Map)
    
    -- Reads from config values and then sets the data to it’s mapped field

    -- mote these are the best range of values I tested.
    if mapGenConfig.DoRandomMapGeneration.Value then
        mapGenConfig.Seed.Value = math.random(-64000, 64000)
        mapGenConfig.Amplitude.Value = math.random(24, 28)
        mapGenConfig.Persistence.Value = Random.new():NextNumber(.48, .52 )
        mapGenConfig.Octaves.Value = math.random(6, 9)
        mapGenConfig.Scale.Value = Random.new():NextNumber(.48, .53)
        

        mapGenConfig.FallOffOffset.Value = math.random(4,8) 
        mapGenConfig.FallOffSmoothness.Value = math.random(4,8)
    end

    self.MapSize = math.clamp(mapGenConfig.MapSize.Value, 4, 512)
    self.TileSize = math.clamp(mapGenConfig.TileSize.Value, 1, 100)

    local seed = math.clamp(mapGenConfig.Seed.Value, -32768, 32768)
    local amplitude =  math.clamp(mapGenConfig.Amplitude.Value, 1, 100)
    local scale =  math.clamp(mapGenConfig.Scale.Value, .1, 1)
    local octaves =  math.clamp(mapGenConfig.Octaves.Value, 1, 10)
    local persistence =  math.clamp(mapGenConfig.Persistence.Value, .1, 1)

    local fallOffOffset =  math.clamp(mapGenConfig.FallOffOffset.Value, 1, 10)
    local fallOffSmoothness =  math.clamp(mapGenConfig.FallOffSmoothness.Value, 1, 10)
    local filterType = math.clamp(mapGenConfig.FilterType.Value, 0, 2)

    local DoGenerateColorMap = mapGenConfig.DoGenerateColorMap
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
                fallOff = FallOffMap.GenerateCircularFallOff(i, j , self.MapSize)
            else
                fallOff = 0
            end

            noiseResult  -= FallOffMap.Transform(fallOff, fallOffOffset, fallOffSmoothness)
            noiseResult  = math.clamp(noiseResult +.5  , 0, 1)

            local tile = aTile:Clone()
            tile.Size = Vector3.new(self.TileSize, self.TileSize, self.TileSize)
            tile.Position = Vector3.new(i * tile.Size.X, tile.Size.Y, j * tile.Size.Z)
            tile.Name = i..","..j

            --//TODO way to be able to visualize different maps simultaneously.
            tile.Color = Color3.new(noiseResult , noiseResult , noiseResult )
            TileMetadata.SetMetadata(noiseResult , tile, theTerrainTypesMap)

            --[[if DoGenerateColorMap.Value then
                ColorMap.SetTerrainColor(tile, theTerrainTypesMap) -- applying terrain
            end--]]
            

            
            tile.Parent = workspace 
        end
    end
    
    return self
end


return Map


















