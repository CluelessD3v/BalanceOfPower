--[[
    This system would take charge of the processing of everything related to buildings before they are actually an
    object in workspace, as well as managing user interaction with it (binds, inout, etc)

]]--

local ReplicatedStorage = game:GetService('ReplicatedStorage')

local CollectionService = game:GetService('CollectionService')
local RunService = game:GetService('RunService')
local UserInputService = game:GetService('UserInputService')
local Maid= require (ReplicatedStorage.Utilities.Maid)

local ConstructionSystemEntity = {} 
ConstructionSystemEntity.__index = ConstructionSystemEntity

function ConstructionSystemEntity.new()
    local self = setmetatable({}, ConstructionSystemEntity)
    
    self.SelectedObject = nil --> //TODO FIXCON 4 rename this  
    self.Mouse = nil
    self.TagsWhiltelist = nil
    self.UpdateBuildingPreview = nil

    self.Maid = Maid.new()
    return self
end


function ConstructionSystemEntity:Init(aSelectedObject, aMouse, aTagsWhitelist) --//TODO FIXCON 4 Type these
    self.SelectedObject = aSelectedObject:Clone()
    self.Mouse = aMouse
    self.TagsWhitelist = aTagsWhitelist

        self.Maid.SelectedObject = self.SelectedObject
    self.Mouse.TargetFilter = self.SelectedObject
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

        print(self.Mouse.Target)
    end))
end

function ConstructionSystemEntity:ExitBuildMode(key: Enum.KeyCode)
    self.ExitBuildModeConnection = UserInputService.InputBegan:Connect(function(anInputObject, isTyping)
        if anInputObject.KeyCode == key and not isTyping then
            print("Out")
            self.Maid:Destroy()
        end
    end)    
end
 
return ConstructionSystemEntity