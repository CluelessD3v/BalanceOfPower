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
local localPlayer = game:GetService('Players').LocalPlayer

-->//TODO FIXCON 3 Clean this module


local ConstructionSystemEntity = {} 
ConstructionSystemEntity.__index = ConstructionSystemEntity

function ConstructionSystemEntity.new()
    local self = setmetatable({}, ConstructionSystemEntity)
    self.SelectedBuilding = nil 
    self.Mouse = nil
    self.TagsWhiltelist = nil
    self.UpdateBuildingPreview = nil

    self.Enabled = nil
    self.Maid = Maid.new()
    return self
end

-------------------- Private methods --------------------
local function PlaceBuilding(self)
    local yOffset =  self.SelectedBuilding.Size.Y/2 + self.Mouse.Target().Size.Y/2
    local placedBuilding = self.SelectedBuilding:Clone()
    placedBuilding.Position = self.Mouse.Target().Position + Vector3.new(0, yOffset, 0)
    placedBuilding.Anchored = true
    placedBuilding.CanCollide = false

    self.Mouse:UpdateTargetFilter({placedBuilding}) --> //TODO NOTE: Make sure that when you implement building destruction, to remove BUILDINGS from the filter list AS WELL!
    
    placedBuilding.Parent = self.Mouse.Target()

    self:Destroy()
end

local function ResetSelectedBuilding(self, aSelectedBuilding)
    -- this is to destroy the previous selected building WHEN a player selects a new one w/O having placed the previous one or exit build mode
    if self.SelectedBuilding then
        self.SelectedBuilding:Destroy()
        self.Maid:DoCleaning()
        self.SelectedBuilding = aSelectedBuilding
    end
end

-------------------- Public methods --------------------

function ConstructionSystemEntity:Init(aSelectedBuilding: BasePart, aMouse: MouseCaster, remote: RemoteEvent) 
    ResetSelectedBuilding(self, aSelectedBuilding)

    self.SelectedBuilding = aSelectedBuilding:Clone()
    self.Maid:GiveTask(self.SelectedBuilding) 
    self.Mouse = aMouse
    self.Enabled = true

    --//TODO FIXCON2/NOTE: Now that I think of it, it would convenient to update the filter here 
    self.Mouse:UpdateTargetFilter({self.SelectedBuilding, localPlayer.Character}) --> update target filter
    
    local function BindBuildingPlacement(_, inputState, _) -->//TODO FIXCON 3 put this in a CAS contexts component module
        if inputState == Enum.UserInputState.Begin then                
            self.Enabled = false
            PlaceBuilding(self)
            remote:FireServer(self.Enabled) --> Flip build mode state if we place a building --> //TODO Fixcon2 put this in the place prefab method
        end
    end

    remote:FireServer(self.Enabled) --> flip buildmode when we initt the construction system?
    ContextActionService:BindAction("InBuildMode", BindBuildingPlacement, false, generalKeys.LMB)
end


function ConstructionSystemEntity:PreviewBuilding()
    local prevTarget = nil
    self.SelectedBuilding.Parent = workspace
    
    self.UpdatePreview = self.Maid:GiveTask(RunService.Heartbeat:Connect(function()
        if self.Mouse.Target() == nil then return end
        if self.Mouse.Target() == prevTarget then return end
        prevTarget = self.Mouse.Target()
        
        print(self.Mouse.Target())
        
        local yOffset =  self.Mouse.Target().Size.Y/2 + self.SelectedBuilding.Size.Y/2
        self.SelectedBuilding.Position = self.Mouse.Target().Position + Vector3.new(0, yOffset, 0)
    end))
end

-------------------- Cleanup methods --------------------
function ConstructionSystemEntity:Destroy()
    ContextActionService:UnbindAction("InBuildMode")
    self.Maid:DoCleaning()
    table.clear(self) --> destroy any remaining cache?
end


function ConstructionSystemEntity:ExitBuildMode(key: Enum.KeyCode, remote)
    self.Maid:GiveTask(UserInputService.InputBegan:Connect(function(anInputObject, isTyping)
        if anInputObject.KeyCode == key and not isTyping then
            print("Out")

            self.Enabled = false
            remote:FireServer(self.Enabled)
            
            self:Destroy()
        end
    end))
end
 
return ConstructionSystemEntity