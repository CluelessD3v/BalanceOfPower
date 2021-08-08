--[[
    This system would take charge of the processing of everything related to buildings before they are actually an
    object in workspace, as well as managing user interaction with it (binds, inout, etc)

]]--

-------------------- Services --------------------

local ReplicatedStorage = game:GetService('ReplicatedStorage')
local ContextActionService = game:GetService('ContextActionService')
local CollectionService = game:GetService('CollectionService')
local RunService = game:GetService('RunService')
local UserInputService = game:GetService('UserInputService')


local Maid = require (ReplicatedStorage.Utilities.Maid)
local keybinds = require(ReplicatedStorage.Components.Keybinds)
local generalKeys = keybinds.GeneralKeys


-->//TODO FIXCON 3 Clean this module


local ConstructionSystemEntity = {} 
ConstructionSystemEntity.__index = ConstructionSystemEntity

function ConstructionSystemEntity.new()
    local self = setmetatable({}, ConstructionSystemEntity)
    self.SelectedObject = nil --> //TODO FIXCON 4 rename this  
    self.Mouse = nil
    self.TagsWhiltelist = nil
    self.UpdateBuildingPreview = nil

    self.Enabled = nil
    self.Maid = Maid.new()

    return self
end


function ConstructionSystemEntity:Init(aSelectedObject, aMouse, aTagsWhitelist, remote) --//TODO FIXCON 4 Type these
    if self.SelectedObject then
        self.SelectedObject:Destroy()
        self.Maid:DoCleaning()
        self.SelectedObject = aSelectedObject
    end

    
    self.SelectedObject = aSelectedObject:Clone()
    self.Maid:GiveTask(self.SelectedObject)

    self.Mouse = aMouse
    self.Maid:GiveTask(self.Mouse)

    self.Enabled = true
    self.TagsWhitelist = aTagsWhitelist
    
    self.Mouse.TargetFilter = self.SelectedObject

    local function BindBuildingPlacement(_, inputState, _) -->//TODO FIXCON 3 put this in a CAS contexts component module
        
        if inputState == Enum.UserInputState.Begin then                
            --newConstructionSystem:PlacePrefab()
            self.Enabled = false
            print("Click")
            remote:FireServer(self.Enabled) --> Flip build mode state if we place a building --> //TODO Fixcon2 put this in the place prefab method
        end
    end

    remote:FireServer(self.Enabled) --> flip buildmode when we initt the construction system?

    print(self.Maid)

    ContextActionService:BindAction("InBuildMode", BindBuildingPlacement, false, generalKeys.LMB)
end


function ConstructionSystemEntity:PreviewBuilding()
    local previousTarget = nil
    self.SelectedObject.Parent = workspace
    
    self.UpdatePreview = self.Maid:GiveTask(RunService.Heartbeat:Connect(function()
        
        if self.Mouse.Target == nil then return end
        if self.Mouse.Target == previousTarget then return end
        previousTarget = self.Mouse.Target
        
        local yOffset =  self.Mouse.Target.Size.Y/2 + self.SelectedObject.Size.Y/2 -->//TODO FIXCON 3 make this an utilty and apply all over the codebase
        self.SelectedObject.Position = self.Mouse.Target.Position + Vector3.new(0, yOffset, 0)
    end))
end


-------------------- Ceanup methods --------------------

function ConstructionSystemEntity:Destroy()
    ContextActionService:UnbindAction("InBuildMode")
    self.Maid:DoCleaning()
    table.clear(self)
end


function ConstructionSystemEntity:ExitBuildMode(key: Enum.KeyCode, remote)
    self.Maid:GiveTask(UserInputService.InputBegan:Connect(function(anInputObject, isTyping)
        if anInputObject.KeyCode == key and not isTyping then
            print("Out")

            self.Enabled = false
            remote:FireServer(self.Enabled)
            
            self:Destroy()
            print(self)
        end
    end))
end
 
return ConstructionSystemEntity