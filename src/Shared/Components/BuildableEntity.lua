local BuildableEntity = {} 
BuildableEntity.__index = BuildableEntity

function BuildableEntity.Preview(aModel:Model)
    local self = setmetatable({}, BuildableEntity)
    self.Model = aModel:Clone()    
    self.PrimaryPart = self.Model.PrimaryPart

    self.PrimaryPart.Transparency = .5

    self.Model.Parent = workspace
    
    return self
end
    

return BuildableEntity