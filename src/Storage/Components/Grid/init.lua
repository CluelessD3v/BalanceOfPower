

local Grid = {} 

local function NewCell(aClassName, aParent, aFieldMap)
    local cell = Instance.new(aClassName)

    for property, value in pairs (aFieldMap.Properties) do 
        cell[property] = value
    end

    cell.Parent = aParent
    return cell
end


Grid.__index = Grid

function Grid.new(aCollumnNumber: number, aRowNumber: number)
    local self = setmetatable({}, Grid)
    
    self.Collums = aCollumnNumber
    self.Rows = aRowNumber

    for i = 1, self.Collums do
        for j = 1, self.Rows do
            
            local cell = NewCell("Part",  workspace.Grid, 
        {
            Properties = {
                Size = Vector3.new(20, 2, 20),
                BrickColor = BrickColor.new("Lime green"),
                Anchored = true,
                CanCollide = true,
                Name = i..","..j,    
            }
        }) 
        
            cell.Position = Vector3.new(i * cell.Size.X, 1, j * cell.Size.Z ) -- set cell size

        end

    end
    

    return self
end
    

 
return Grid
