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

-------------------- Utiltiies --------------------
local Maid = require (ReplicatedStorage.Utilities.Maid)
local MapDataToInstance = require(ReplicatedStorage.Utilities.MapDataToInstance)
local keybinds = require(ReplicatedStorage.Components.Keybinds)
local generalKeys = keybinds.GeneralKeys

local ConstructionSystemEntity = {} 
ConstructionSystemEntity.__index = ConstructionSystemEntity

function ConstructionSystemEntity.new()
    local self = setmetatable({}, ConstructionSystemEntity)
    self.Maid = Maid.new()
    return self
end


-------------------- Private methods --------------------
-- destroy the previous selected building (if any) WHEN a player selects a new one  
local function ResetSelectedBuilding(self, aSelectedBuilding)
    if self.SelectedBuilding then
        self.SelectedBuilding:Destroy()
        self.Maid:DoCleaning()
        self.SelectedBuilding = aSelectedBuilding   
    end
end


local function IsTileValid(self, buildingComponent)
    if CollectionService:HasTag(self.Mouse.Target(), "OccupiedTile") then 
        print("Tile occupied")
        return 
    end

    for _, filteredTag in ipairs(buildingComponent.ExtraData.FilteredTags) do
        if CollectionService:HasTag(self.Mouse.Target(), filteredTag) then
            print("Building cannot be placed here")
            return
        end
    end
end

local function PlaceBuilding(self)
    local yOffset =  self.SelectedBuilding.Size.Y/2 + self.Mouse.Target().Size.Y/2
    local placedBuilding = self.SelectedBuilding:Clone()
   
    placedBuilding.Position = self.Mouse.Target().Position + Vector3.new(0, yOffset, 0)
    placedBuilding.Anchored = true
    placedBuilding.CanCollide = false
    placedBuilding.Transparency = 0

    self.Mouse:UpdateTargetFilter({placedBuilding})
    
    placedBuilding.Parent = self.Mouse.Target()
end

-- when a building is placed, the tile metadata must be updated
local function UpdateTileData(self)
    self.Mouse.Target():SetAttribute("Occupied", true)

    MapDataToInstance(self.Mouse.Target(), {
        Tags = {"OccupiedTile"},
        Attributes = {Building = self.SelectedBuilding.Name}
    })
end

-------------------- Public methods --------------------
function ConstructionSystemEntity:Init(aSelectedBuilding:any, aMouse:MouseCaster, SetBuildModeEvent:RemoteEvent, aTagsBlacklist:table) 
    ResetSelectedBuilding(self, aSelectedBuilding)

    self.SelectedBuilding = aSelectedBuilding:Clone()
    self.SelectedBuilding.Transparency = .5

    self.Maid:GiveTask(self.SelectedBuilding) 
    
    self.Mouse = aMouse
    self.Enabled = true

    self.FilterList = aTagsBlacklist
    
    --> update target filter with latest info, and the selected building.
    self.Mouse:UpdateTargetFilter({self.SelectedBuilding}) 
    self.Mouse:UpdateTargetFilterFromTags(aTagsBlacklist)

    local function BindBuildingPlacement(_, inputState, _) 
        if inputState == Enum.UserInputState.Begin then
            IsTileValid(self)                
            PlaceBuilding(self)
            UpdateTileData(self)

            self.Enabled = false
            SetBuildModeEvent:FireServer(self.Enabled, self) --> Exit build mode state if we place a building

            self:Destroy() -->//todo DEFCON4: rewrite this bit to account for multiple building placement selection, E.G: Hold shift and you can keep adding the same building.

        end
    end

    SetBuildModeEvent:FireServer(self.Enabled) --> flip buildmode when we initt the construction system?
    ContextActionService:BindAction("InBuildMode", BindBuildingPlacement, false, generalKeys.LMB)
end

-- set and Update the building preview position in the world map
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


function ConstructionSystemEntity:ExitBuildMode(key: Enum.KeyCode, SetBuildModeEvent: RemoteEvent)
    self.Maid:GiveTask(UserInputService.InputBegan:Connect(function(anInputObject, isTyping)
        if anInputObject.KeyCode == key and not isTyping then
            self.Enabled = false
            SetBuildModeEvent:FireServer(self.Enabled)
            
            self:Destroy()
        end
    end))
end
 
return ConstructionSystemEntity