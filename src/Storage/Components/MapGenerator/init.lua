local PerlinNoise = require(script.PerlinNoise)
local Lerp = require(game:GetService('ReplicatedStorage').Utilities.RbxCookbook.Lerp)
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
    elseif  noiseResult < .53 then
        tile.BrickColor = littoral        
    elseif  noiseResult < .60 then
        tile.BrickColor = beach
    elseif  noiseResult < .80 then
        tile.BrickColor = grassLand
    elseif  noiseResult < .90 then
        tile.BrickColor = forest
    elseif  noiseResult < .99 then
        tile.BrickColor = hill
    elseif  noiseResult <= 1 then
        tile.BrickColor = mountain
    end

end

function MapGenerator.new(theGridSize, theTileSize, aSeed)
    local self = setmetatable({}, MapGenerator)
    self.Length = theGridSize
    self.Width = theGridSize

    local scale = .45
    local seed = aSeed

    for i = 1, self.Length do
        for j = 1, self.Width do
            local tile = Instance.new("Part")
            tile.Size = Vector3.new(theTileSize, 2, theTileSize)
            tile.Position = Vector3.new(i * tile.Size.X, 1, j * tile.Size.Z)
            tile.Anchored = true
            tile.Material = Enum.Material.SmoothPlastic
            tile.BrickColor = BrickColor.new("Really red")

            local noiseResult = PerlinNoise.new({(i + seed) * scale, (j + seed) * scale}, 11, 11, .68)
           
            local function Evaluate(fallOffValue, power, offset)
                math.clamp(power, 1, 5)
                math.clamp(offset, 1, 5)
                local a = power
                local b = offset

                return math.pow(fallOffValue, a)/(math.pow(fallOffValue, a) + math.pow(b-b*fallOffValue, a))
            end

            local widthFallOff = math.abs(i/theGridSize * 2 - 1)
            local lengthFallOff = math.abs(j/theGridSize * 2 - 1)
            local fallOff = math.max(widthFallOff, lengthFallOff)
            local evaluation = Evaluate(fallOff, 2.5, 3.5)

            noiseResult -= evaluation 
            noiseResult = math.clamp(noiseResult + 0.5 , 0, 1)


            --tile.Color = Color3.new(noiseResult, noiseResult, noiseResult)
            --tile.Color = Color3.new(fallOff, fallOff, fallOff)
            ColorMap(tile, noiseResult)

           
            tile.Parent = workspace.Grid
        end
    end


    return self
end
    

return MapGenerator


















