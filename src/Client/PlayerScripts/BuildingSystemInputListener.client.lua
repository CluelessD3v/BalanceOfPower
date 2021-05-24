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
local playerValues = player:WaitForChild("Values")
local mouse = Players.LocalPlayer:GetMouse()


local prototypeAsset = CollectionService:GetTagged("Building")[1]

UserInputService.InputBegan:Connect(function(anInput)
    if anInput.KeyCode == Enum.KeyCode.E then
        local isInBuildmode = ToggleBuildMode(player)
        
        if isInBuildmode then
            local buildingPreview = prototypeAsset:Clone()
            buildingPreview.Parent = workspace
            playerValues.SelectedObject.Value = buildingPreview

            mouse.TargetFilter = buildingPreview

            RunService.Heartbeat:Connect(function()
                local target = mouse.Target
                playerValues.SelectedObject.Value:SetPrimaryPartCFrame(CFrame.new(target.Position + Vector3.new(0, 2, 0 )))
            end)
        
        else
            playerValues.SelectedObject.Value:Destroy()
        
        end
    end
end)


UserInputService.InputBegan:Connect(function(anInput)
    if anInput.UserInputType  == Enum.UserInputType.MouseButton1 and playerValues.IsInBuildMode.Value then
        print("...")
        local building = BuildableEntity.new(playerValues.SelectedObject.Value, mouse)
        building.Model.Parent = workspace
        print(building, "something")
    end
end)