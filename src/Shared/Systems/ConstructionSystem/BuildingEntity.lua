local CollectionService = game:GetService('CollectionService')
local RunService = game:GetService('RunService')




local BuildingEntity = {} 
BuildingEntity.__index = BuildingEntity

function BuildingEntity.new(anInstance: any, anEntityWhitelist: table, thePlayerMouse: Mouse)
    local self = setmetatable({}, BuildingEntity)

    self.SelectedObject = anInstance:Clone()
    self.SelectedObject.CanCollide = false
    self.SelectedObject.Anchored = true
    self.SelectedObject.Parent = workspace
    

    self.Whitelist = anEntityWhitelist
    self.Mouse = thePlayerMouse
    
    self.Connection = nil
    return self
end
    

function BuildingEntity:PreviewBuilding()
    print(self.Mouse)
    self.Connection = RunService.Heartbeat:Connect(function()
        
        if self.Mouse.Target == nil  then return end

        for _, tag in ipairs(self.Whitelist) do
            if not CollectionService:HasTag(self.Mouse.Target, tag) then
                return
            end
        end
        print(self.Mouse.Target)
        
        local yOffset =  self.Mouse.Target.Size.Y/2 + self.SelectedObject.Size.Y/2
        self.SelectedObject.Position = self.Mouse.Target.Position + Vector3.new(0, yOffset, 0)
    end) 
    

end


function BuildingEntity:Destroy()

    self.SelectedObject:Destroy()
    self.Connection:Disconnect() 

    -- Order matters here, first destroy, then nil!
    self.SelectedObject = nil

   
end

return BuildingEntity

