local CollectionService = game:GetService('CollectionService')
local RunService = game:GetService('RunService')




local BuildingEntity = {} 
BuildingEntity.__index = BuildingEntity

function BuildingEntity.new(x, y, z, a)
    local self = setmetatable({}, BuildingEntity)

    self.Inst = x:Clone()
    self.Inst.CanCollide = false
    self.Inst.Anchored = true
    self.Inst.Parent = a or workspace
        
    self.Con = nil

    self.List = y
    self.Mouse = z
    print(self.Mouse)
    return self
end
    

function BuildingEntity:PreviewBuilding()
    print(self.Mouse)
    self.Con = RunService.Heartbeat:Connect(function()
        if self.Mouse.Target == nil  then return end
        for _, tag in ipairs(self.List) do
            if not CollectionService:HasTag(self.Mouse.Target, tag) then
                return
            end
            print(self.Mouse.Target)

            self.Inst.Position = self.Mouse.Target.Position + Vector3.new(0,10,0) 
        end 
    end) 
    

end


function BuildingEntity:Dispose()
    self.Inst:Destroy()
    self.Con:Disconnect()    
end

return BuildingEntity

