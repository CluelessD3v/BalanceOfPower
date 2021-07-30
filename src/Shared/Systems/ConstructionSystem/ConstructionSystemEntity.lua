--[[
    This system would take charge of the processing of everything related to buildings before they are actually an
    object in workspace, as well as managing user interaction with it (binds, inout, etc)

]]--

local CollectionService = game:GetService('CollectionService')
local RunService = game:GetService('RunService')


local ConstructionSystemEntity = {} 
ConstructionSystemEntity.__index = ConstructionSystemEntity

function ConstructionSystemEntity.new(theSelectedBuilding: any, thePlayerMouse: Mouse,  anEntityWhitelist: table)
    local self = setmetatable({}, ConstructionSystemEntity)

    self.SelectedBuilding = theSelectedBuilding:Clone()
    self.SelectedBuilding.CanCollide = false
    self.SelectedBuilding.Anchored = true
    self.SelectedBuilding.Parent = workspace
    self.Whitelist = anEntityWhitelist
    self.Mouse = thePlayerMouse

    self.PreviousTarget = nil
    self.Connection = nil
    return self
end
    
function ConstructionSystemEntity:PreviewBuilding()

    self.Connection = RunService.Heartbeat:Connect(function()
        if self.Mouse.Target == nil then return end
        if self.Mouse.Target == self.PreviousTarget then return end
        self.Mouse.TargetFilter = self.SelectedBuilding
        
        for _, tag in ipairs(self.Whitelist) do
            if not CollectionService:HasTag(self.Mouse.Target, tag) then
                return
            end
        end
        
        local yOffset =  self.Mouse.Target.Size.Y/2 + self.SelectedBuilding.Size.Y/2
        self.SelectedBuilding.Position = self.Mouse.Target.Position + Vector3.new(0, yOffset, 0)
        self.PreviousTarget = self.Mouse.Target
    end) 
    

end

function ConstructionSystemEntity:PlacePrefab()
    
    print(self.PreviousTarget)
end

function ConstructionSystemEntity:Destroy()

    self.SelectedBuilding:Destroy()
    self.Connection:Disconnect() 

    -- Order matters here, first destroy, then nil!
    self.SelectedBuilding = nil

   
end

return ConstructionSystemEntity