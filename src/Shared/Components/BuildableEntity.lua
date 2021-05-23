local BuildableEntity = {} 
BuildableEntity.__index = BuildableEntity

function BuildableEntity.new(aModel:Model)
    local self = setmetatable({}, BuildableEntity)
    self.Model = aModel:Clone()    
    self.PrimaryPart = self.Model.PrimaryPart
    self.PrimaryPart.Transparency = .5
    return self
end


function BuildableEntity:Construct(args)
    
end
    

return BuildableEntity