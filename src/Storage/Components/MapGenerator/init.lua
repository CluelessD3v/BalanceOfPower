local PerlinNoise = require(script.PerlinNoise)

local MapGenerator = {} 
MapGenerator.__index = MapGenerator


local ocean = BrickColor.new("Bright blue")
local littoral= BrickColor.new("Cyan")
local beach = BrickColor.new("Daisy orange")
local grassLand = BrickColor.new("Shamrock")
local forest = BrickColor.new("Forest green")
local hill = BrickColor.new("Medium stone grey")
local mountain = BrickColor.new("Dark stone grey")

local function ColorMap(tile, noiseResult)
                
    if noiseResult < 0.1 then 
        tile.BrickColor = ocean
    elseif  noiseResult < .50 then
        tile.BrickColor = littoral        
    elseif  noiseResult < .55 then
        tile.BrickColor = beach
    elseif  noiseResult < .76 then
        tile.BrickColor = grassLand
    elseif  noiseResult < .95 then
        tile.BrickColor = forest
    elseif  noiseResult < .999 then
        tile.BrickColor = hill
    elseif  noiseResult <= 1 then
        tile.BrickColor = mountain
    end

end

function MapGenerator.new(theMapGenfieldMap)
    local self = setmetatable({}, MapGenerator)
    self.MapSize = theMapGenfieldMap.MapSize
    self.TileSize = theMapGenfieldMap.TileSize
    
    local seed = theMapGenfieldMap.Seed
    local amplitude = theMapGenfieldMap.Amplitude
    local scale = theMapGenfieldMap.Scale
    local octaves = theMapGenfieldMap.Octaves
    local persistence = theMapGenfieldMap.Persistence

    local fallOffOffset = theMapGenfieldMap.FallOffOffset
    local fallOffPower = theMapGenfieldMap.FallOffPower


    for i = 1, self.MapSize do
        for j = 1, self.MapSize do
            local tile = Instance.new("Part")
            tile.Size = Vector3.new(self.TileSize, 2, self.TileSize)
            tile.Position = Vector3.new(i * tile.Size.X, 1, j * tile.Size.Z)
            tile.Anchored = true
            tile.Material = Enum.Material.SmoothPlastic
            tile.BrickColor = BrickColor.new("Really red")

            local noiseResult = PerlinNoise.new({(i + seed) * scale, (j + seed) * scale}, amplitude, octaves, persistence)
           
            local function Evaluate(fallOffValue, anOffset, aPower)
                local a = aPower
                local b = anOffset

                return math.pow(fallOffValue, a)/(math.pow(fallOffValue, a) + math.pow(b-b*fallOffValue, a))
            end

            local widthFallOff = math.abs(i/self.MapSize * 2 - 1)
            local lengthFallOff = math.abs(j/self.MapSize * 2 - 1)
            local fallOff = math.max(widthFallOff, lengthFallOff)
            local evaluation = Evaluate(fallOff, fallOffOffset, fallOffPower)

            noiseResult -= evaluation
            noiseResult = math.clamp(noiseResult + 0.5 , 0, 1)


            --tile.Color = Color3.new(noiseResult, noiseResult, noiseResult)
            --tile.Color = Color3.new(fallOff, fallOff, fallOff)
            ColorMap(tile, noiseResult)

           
            tile.Parent = workspace.Map
        end
    end


    return self
end
    

return MapGenerator


















