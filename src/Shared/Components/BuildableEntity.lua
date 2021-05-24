

local BuildableEntity = {} 
BuildableEntity.__index = BuildableEntity

function BuildableEntity.new(aModel:Model, mouse)
    local self = setmetatable({}, BuildableEntity)
    print("in")
    self.Model = aModel:Clone()    
    self.PrimaryPart = self.Model.PrimaryPart
    self.PrimaryPart.Transparency = 0

    self.Model:SetPrimaryPartCFrame(CFrame.new(mouse.Target.Position + Vector3.new(0, 2, 0)))
    return self
end

    

return BuildableEntity