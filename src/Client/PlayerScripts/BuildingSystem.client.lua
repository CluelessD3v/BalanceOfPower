-- Services
local UserInputService = game:GetService('UserInputService')
local RunService = game:GetService('RunService')
local Players = game:GetService('Players')

-- modules
local BuildingSystem = require(game:GetService('ReplicatedStorage').Components.BuildingSystem)
-- Data
local player = Players.LocalPlayer
local mouse = Players.LocalPlayer:GetMouse()


UserInputService.InputBegan:Connect(function(anInput)
    local isInBuildMode = player.Values.IsInBuildMode

    if anInput.KeyCode == Enum.KeyCode.E then
        isInBuildMode.Value = not isInBuildMode.Value
        BuildingSystem.ToggleBuildMode(player, mouse)
    end
end)