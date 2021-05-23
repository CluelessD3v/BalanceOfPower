-- Services
local UserInputService = game:GetService('UserInputService')
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local Players = game:GetService('Players')
local CollectionService = game:GetService('CollectionService')
local RunService = game:GetService('RunService')

-- modules
local BuildableEntity = require(ReplicatedStorage.Components.BuildableEntity)


local function ToggleBuildMode(aPlayer: Player)
    local isInBuildMode = aPlayer.Values.IsInBuildMode
    isInBuildMode.Value = not isInBuildMode.Value

    return isInBuildMode.Value
end



-- Data
local player = Players.LocalPlayer
local mouse = Players.LocalPlayer:GetMouse()
local PreviewBuildingEvent = ReplicatedStorage.Events.PreviewBuildingEvent

UserInputService.InputBegan:Connect(function(anInput)
    if anInput.KeyCode == Enum.KeyCode.E then
        
        local isInBuildmode = ToggleBuildMode(player)        
        
        if isInBuildmode then
            local buildingPreview = BuildableEntity.Preview(CollectionService:GetTagged("Building")[1])  

            RunService.Heartbeat:Connect(function()
                local target = mouse.Target
                mouse.TargetFilter = buildingPreview.Model
                print(target)
                buildingPreview.Model:SetPrimaryPartCFrame(CFrame.new(target.Position + Vector3.new(0, 2, 0 )))
            end)
        end
    end
end)