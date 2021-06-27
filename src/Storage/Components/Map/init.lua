local ReplicatedStorage = game:GetService('ReplicatedStorage')
local CollectionService = game:GetService('CollectionService')

local PerlinNoise = require(script.Parent.PerlinNoise)
local FallOffMap = require(script.FallOffMap)
local ColorMap = require(script.ColorMap)
local TileMetadata = require(script.TileMetadata)

local CustomInstance = require(ReplicatedStorage.Utilities.CustomInstance)

local Map = {} 
Map.__index = Map

function Map.new(theMapGenValueMap: table, aTile, theTerrainTypesMap: table)
    local self = setmetatable({}, Map)
    self.MapSize = theMapGenValueMap.MapSize
    self.TileSize = theMapGenValueMap.TileSize
    
    local seed = theMapGenValueMap.Seed
    local amplitude = theMapGenValueMap.Amplitude
    local scale = theMapGenValueMap.Scale
    local octaves = theMapGenValueMap.Octaves
    local persistence = theMapGenValueMap.Persistence

    local fallOffOffset = theMapGenValueMap.FallOffOffset   
    local fallOffPower = theMapGenValueMap.FallOffSmoothness

    for i = 1, self.MapSize do
        for j = 1, self.MapSize do
            -- Noise and fall off calculations
            local noiseResult  = PerlinNoise.new({(i + seed) * scale, (j + seed) * scale}, amplitude, octaves, persistence)
            local fallOff = FallOffMap.GenerateCircularFallOff(i, j , self.MapSize)
            noiseResult  -= FallOffMap.Transform(fallOff, fallOffOffset, fallOffPower)
            noiseResult  = math.clamp(noiseResult  + 0.5 , 0, 1)

            
            local tile = aTile.Asset:Clone()
            tile.Size = Vector3.new(self.TileSize, self.TileSize, self.TileSize)
            tile.Position = Vector3.new(i * tile.Size.X, tile.Size.Y, j * tile.Size.Z)
            tile.Name = fallOff

            --//TODO way to be able to visualize different maps simultaneously.
            tile.Color = Color3.new(noiseResult , noiseResult , noiseResult )
            TileMetadata.SetMetadata(noiseResult , tile, theTerrainTypesMap)
            ColorMap.SetTerrainColor(tile) -- applying terrain
            tile.Parent = workspace 
        end
    end
    
    return self
end





return Map


















