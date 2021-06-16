local PerlinNoise = require(game:GetService('ReplicatedStorage').Utilities.PerlinNoise)
local GridObject = {} 
GridObject.__index = GridObject

local function Lerp (t, a, b)
    return a + t * (b - a)
end

function GridObject.new(theGridSize, theTileSize)
    local self = setmetatable({}, GridObject)
    self.Length = theGridSize
    self.Width = theGridSize
    local seed = math.random(-100 , 100)
    for i = 1, self.Length do
        for j = 1, self.Width do
            local tile = Instance.new("Part")
            tile.Size = Vector3.new(theTileSize, 2, theTileSize)
            tile.Position = Vector3.new(i * tile.Size.X, 1, j * tile.Size.Z)
            tile.Anchored = true
            tile.BrickColor = BrickColor.new("Really red")

            local noiseResult = PerlinNoise.new({i + seed, j + seed}, 10, 10, .75)
            noiseResult = math.clamp(noiseResult + 0.5 , 0, 1)

            tile.Color = Color3.new(noiseResult, noiseResult, noiseResult)

            tile.Parent = workspace.Grid
        end
    end

    wait(10)

    return self
end
    

return GridObject