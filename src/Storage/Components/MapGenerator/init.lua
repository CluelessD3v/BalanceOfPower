local ReplicatedStorage = game:GetService('ReplicatedStorage')
local CollectionService = game:GetService('CollectionService')

local PerlinNoise = require(script.PerlinNoise)
local FallOffMap = require(script.FallOffMap)
local ColorMap = require(script.ColorMap)


local CustomInstance = require(ReplicatedStorage.Utilities.CustomInstance)

local function SetTileIdentificators(aTile: Instance, aValue: number)
    if aValue < 0.1 then 
        CollectionService:AddTag(aTile, "Sea")
        aTile:SetAttribute("TerrainType", "Sea")

    elseif  aValue < .48 then
        CollectionService:AddTag(aTile, "Littoral")
        aTile:SetAttribute("TerrainType", "Littoral")
        
    elseif  aValue < .53 then
        CollectionService:AddTag(aTile, "Beach")
        aTile:SetAttribute("TerrainType", "Beach")

    elseif  aValue < .82 then
        CollectionService:AddTag(aTile, "Plains")
        aTile:SetAttribute("TerrainType", "Plains")

    elseif  aValue < .9999 then
        CollectionService:AddTag(aTile, "Forest")
        aTile:SetAttribute("TerrainType", "Forest")

    elseif  aValue <= 1 then
        CollectionService:AddTag(aTile, "Mountain")
        aTile:SetAttribute("TerrainType", "Mountain")
    end
end


local MapGenerator = {} 
MapGenerator.__index = MapGenerator

function MapGenerator.new(aFieldMap)
    local self = setmetatable({}, MapGenerator)
    self.MapSize = aFieldMap.MapSize
    self.TileSize = aFieldMap.TileSize
    self.Generated = false
    

    local seed = aFieldMap.Seed
    local amplitude = aFieldMap.Amplitude
    local scale = aFieldMap.Scale
    local octaves = aFieldMap.Octaves
    local persistence = aFieldMap.Persistence

    local fallOffOffset = aFieldMap.FallOffOffset
    local fallOffPower = aFieldMap.FallOffPower

    for i = 1, self.MapSize do
        for j = 1, self.MapSize do
            -- Noise and fall off calculations
            local noiseResult = PerlinNoise.new({(i + seed) * scale, (j + seed) * scale}, amplitude, octaves, persistence)
            local fallOff = FallOffMap.Generate(i, j , self.MapSize)        
            noiseResult -= FallOffMap.Transform(fallOff, fallOffOffset, fallOffPower) -- substract the fall off result from the noise result
            noiseResult = math.clamp(noiseResult + 0.5 , 0, 1) -- 2D perlin noise generates values from - .5 to + .5, added .5 to get full range

            -- Create tile //TODO CHECK IF I SHOULD ObjectIfy TILES
            local tile = CustomInstance.new("Part", {
                Properties = {
                    Size = Vector3.new(self.TileSize, self.TileSize, self.TileSize),   
                    Position = Vector3.new(i * self.TileSize, 1, j * self.TileSize),
                    Anchored = true,
                    Material = Enum.Material.SmoothPlastic,
                    BrickColor = BrickColor.new("Really red"),
                    Name = i..","..j
                },
                Attributes = {
                    NoiseValue = noiseResult,
                    Xpos = i,
                    Ypos = j,
                    TerrainType = "NoTerrain"
                },
                Tags = {
                    "Tile",
                }
            })


            --//TODO way to be able to visualize different maps simultaneously.
            --tile.Color = Color3.new(noiseResult, noiseResult, noiseResult)
            --tile.Color = Color3.new(fallOff, fallOff, fallOff)
            SetTileIdentificators(tile, noiseResult)
            ColorMap.SetTerrainColor(tile) -- applying terrain
            tile.Parent = workspace.Map
        end
    end


    
    self.Generated = true
    return self
end


return MapGenerator


















