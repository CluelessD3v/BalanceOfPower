local GridObject = {} 
GridObject.__index = GridObject

function GridObject.new(theGridSize, theTileSize)
    local self = setmetatable({}, GridObject)
    self.Length = theGridSize
    self.Width = theGridSize

    for i = 1, self.Length do
        for j = 1, self.Width do
            local tile = Instance.new("Part")
            tile.Size = Vector3.new(theTileSize, 2, theTileSize)
            tile.Position = Vector3.new(i * tile.Size.X, 1, j * tile.Size.Z)
            tile.Anchored = true
            tile.BrickColor = BrickColor.new("Really red")

            tile.Parent = workspace
        end
    end

    wait(10)

    return self
end
    

return GridObject