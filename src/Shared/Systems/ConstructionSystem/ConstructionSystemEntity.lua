--[[
    This system would take charge of the processing of everything related to buildings before they are actually an
    object in workspace, as well as managing user interaction with it (binds, inout, etc)

]]--

local CollectionService = game:GetService('CollectionService')
local RunService = game:GetService('RunService')
local UserInputService = game:GetService('UserInputService')


local ConstructionSystemEntity = {} 
ConstructionSystemEntity.__index = ConstructionSystemEntity

function ConstructionSystemEntity.new(theSelectedBuilding: BasePart, thePlayerMouse: Mouse,  aValidTilesList: table)
    local self = setmetatable({}, ConstructionSystemEntity)

    self.Prefab = theSelectedBuilding
    self.BuildingPreview = self.Prefab:Clone() 
    
    self.BuildingPreview.CanCollide = false
    self.BuildingPreview.Anchored = true
    self.BuildingPreview.Transparency = .5
    
    self.BuildingPreview.Parent = workspace

    self.ValidTilesList = aValidTilesList
    self.Mouse = thePlayerMouse

    self.PreviousTarget = nil --> form of debounce to avoid processing on the same tile (DOES NOOT DISCONNECTS!)
    self.UpdatePreviewPosCon = nil --> Connection of the update loop that updates the prefab position
    self.ExitBuildModeConnection = nil --> holds the connection of the exit UIS InputBegan event binded to exit build mode
    return self
end
    
function ConstructionSystemEntity:PreviewBuilding()

    self.UpdatePreviewPosCon = RunService.Heartbeat:Connect(function()
        if self.Mouse.Target == nil then return end
        if self.Mouse.Target == self.PreviousTarget then return end
        self.Mouse.TargetFilter = self.BuildingPreview

        for _, tag in ipairs(self.ValidTilesList) do
            if not CollectionService:HasTag(self.Mouse.Target, tag) then
                return
            end
        end
        print(self.Mouse.Target)
        
        local yOffset =  self.Mouse.Target.Size.Y/2 + self.BuildingPreview.Size.Y/2
        self.BuildingPreview.Position = self.Mouse.Target.Position + Vector3.new(0, yOffset, 0)
        self.PreviousTarget = self.Mouse.Target
    end) 
    

end

function ConstructionSystemEntity:ExitBuildMode(remoteFunction: RemoteFunction, key: Enum.KeyCode)
    self.ExitBuildModeConnection = UserInputService.InputBegan:Connect(function(anInputObject, isTyping)
        if anInputObject.KeyCode == key and not isTyping then
            print("Exited build mode")
            remoteFunction:InvokeServer()
        end
    end)    
end

function ConstructionSystemEntity:Destroy()
    self.BuildingPreview:Destroy() --> destroy the preview
    self.UpdatePreviewPosCon:Disconnect() 
    self.ExitBuildModeConnection:Disconnect()
    -- Order matters here, first destroy, then nil!
    self.BuildingPreview = nil
    self.Mouse = nil
    self.PreviousTarget = nil
    self.ValidTilesList = nil
end





function ConstructionSystemEntity:PlacePrefab()
    self.Mouse.TargetFilter = self.BuildingPreview
    for _, tag in ipairs(self.ValidTilesList) do
        if not CollectionService:HasTag(self.Mouse.Target, tag) then
            return
        end
    end
    
    local newBuilding = self.Prefab:Clone()
    local yOffset =  self.Mouse.Target.Size.Y/2 + newBuilding.Size.Y/2
    
    newBuilding.Position = self.Mouse.Target.Position + Vector3.new(0, yOffset, 0)
    newBuilding.Parent = self.Mouse.Target
    print("Building placed in:", newBuilding.Parent)

end

return ConstructionSystemEntity