-- Services
local UserInputService = game:GetService('UserInputService')
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local Players = game:GetService('Players')
local CollectionService = game:GetService('CollectionService')
local RunService = game:GetService('RunService')

-- modules
local BuildableEntity = require(ReplicatedStorage.Components.BuildableEntity)
local ConstructionService = require(ReplicatedStorage.Systems.ConstructionService)

-- Data
local player = Players.LocalPlayer
local playerValues = player:WaitForChild("Values")
local mouse = Players.LocalPlayer:GetMouse()

local filteredEntities = {}


local prototypeAsset = CollectionService:GetTagged("Building")[1]

UserInputService.InputBegan:Connect(function(anInput)
    if anInput.KeyCode == Enum.KeyCode.E then
        local isInBuildmode = ConstructionService.ToggleBuildMode(player)
        
        if isInBuildmode then
            local buildingPreview =  ConstructionService.GetPreview(prototypeAsset)
            
            playerValues.SelectedObject.Value = buildingPreview
            mouse.TargetFilter = buildingPreview

            RunService.Heartbeat:Connect(function()
                local target = mouse.Target
                playerValues.SelectedObject.Value:SetPrimaryPartCFrame(CFrame.new(target.Position + Vector3.new(0, 2, 0 )))
            end)
        
        else
            playerValues.SelectedObject.Value:Destroy()
            playerValues.SelectedObject.Value = nil
        end
    end
end)

--//TODO Check if this code can be simplified in a way that makes sensae
UserInputService.InputBegan:Connect(function(anInput)
    if anInput.UserInputType  == Enum.UserInputType.MouseButton1 and playerValues.IsInBuildMode.Value then
        local target = mouse.Target
        
        if target:GetAttribute("IsOccupied") or not target:GetAttribute("IsACell") then
            print("Cell occupied or not a cell")
            return
        end

        local building = BuildableEntity.new(playerValues.SelectedObject.Value, mouse)
        building.Model.Parent = mouse.Target
        building.Model.Parent:SetAttribute("OccupiedBy", building.Model.Name)
        target:SetAttribute("IsOccupied", true)
        filteredEntities.Insert(building.Model)
    end
end)

mouse.TargetFilter(unpack(filteredEntities))