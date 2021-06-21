local ReplicatedStorage = game:GetService('ReplicatedStorage')
local CollectionService = game:GetService('CollectionService')

local PerlinNoise = require(script.PerlinNoise)
local FallOffMap = require(script.FallOffMap)
local TerrainMap = require(script.TerrainMap)


local CustomInstance = require(ReplicatedStorage.Utilities.CustomInstance)

local Lerp = require(ReplicatedStorage.Utilities.RbxCookbook.Lerp)


local MapGenerator = {} 
MapGenerator.__index = MapGenerator

function MapGenerator.new(aFieldMap)
    local self = setmetatable({}, MapGenerator)
    self.MapSize = aFieldMap.MapSize
    self.TileSize = aFieldMap.TileSize
    

    local seed = aFieldMap.Seed
    local amplitude = aFieldMap.Amplitude
    local scale = aFieldMap.Scale
    local octaves = aFieldMap.Octaves
    local persistence = aFieldMap.Persistence

    local fallOffOffset = aFieldMap.FallOffOffset
    local fallOffPower = aFieldMap.FallOffPower

    for i = 1, self.MapSize do
        for j = 1, self.MapSize do
            local noiseResult = PerlinNoise.new({(i + seed) * scale, (j + seed) * scale}, amplitude, octaves, persistence)

            local widthFallOff = math.abs(i/self.MapSize * 2 - 1)
            local lengthFallOff = math.abs(j/self.MapSize * 2 - 1)
            local result = math.max(widthFallOff, lengthFallOff)
            local fallOff = FallOffMap(result , fallOffOffset, fallOffPower)

            
            noiseResult -= fallOff
            noiseResult = math.clamp(noiseResult + 0.5 , 0, 1)

            local tile = CustomInstance.new("Part", {
                Properties = {
                    Size = Vector3.new(self.TileSize, self.TileSize, self.TileSize),   
                    Position = Vector3.new(i * self.TileSize, 1, j * self.TileSize),
                    Anchored = true,
                    Material = Enum.Material.SmoothPlastic,
                    BrickColor = BrickColor.new("Really red"),
                    Name = i ..",".. j
                },

                Attributes = {
                    NoiseValue = noiseResult
                },

                

                Tags = {
                    "Tile",
                }
            })


            --tile.Color = Color3.new(noiseResult, noiseResult, noiseResult)
            --tile.Color = Color3.new(fallOff, fallOff, fallOff)
            TerrainMap.ApplyTerrain(tile, noiseResult)
        
            
            tile.Parent = workspace.Map
        end
    end


    

    return self
end





return MapGenerator


















