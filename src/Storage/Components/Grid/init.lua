local Grid = {} 


local function NewCell(aSize)
    local cell = Instance.new("Part")
    cell.Size = Vector3.new(aSize, 1, aSize)
    cell.Anchored = true
    cell.Parent = workspace
    return cell
end

Grid.__index = Grid

function Grid.new(aCollumnNumber: number, aRowNumber: number)
    local self = setmetatable({}, Grid)
    
    self.DesginerMode = script:GetAttribute("DesignerMode")

    if self.DesginerMode then
        self.Collums = script:GetAttribute("Height")
        self.Rows = script:GetAttribute("Width")
    else
        self.Collums = aCollumnNumber
        self.Rows = aRowNumber
    end

    for i = 1, self.Collums do
        for j = 1, self.Rows do
            local cell = NewCell(20)
            cell.Position = Vector3.new(i * cell.Size.X, 1, j * cell.Size.Z )
        end

    end
    

    return self
end
    

return Grid