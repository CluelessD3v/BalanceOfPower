-- Utils
local CustomInstance = require(game:GetService('ReplicatedStorage').Utilities.CustomInstance)

local Grid = {} 

Grid.__index = Grid

function Grid.new(aCollumnNumber: number, aRowNumber: number)
    local self = setmetatable({}, Grid)
    
    self.Collums = aCollumnNumber
    self.Rows = aRowNumber

    for i = 1, self.Collums do
        for j = 1, self.Rows do
            
            local cell = CustomInstance.new("Part",  workspace.Grid, 
        {
            Properties = {
                Size = Vector3.new(20, 2, 20),
                BrickColor = BrickColor.new("Lime green"),
                Anchored = true,
                CanCollide = true,
                Name = i..","..j,    
            },

            Attributes = {
                IsOccupied = false,
                IsACell = true,
                OccupiedBy = "null"
                   
            }
        }) 
        
            cell.Position = Vector3.new(i * cell.Size.X, 1, j * cell.Size.Z ) -- set cell size

        end

    end
    

    return self
end
    

 
return Grid
