-- Services
local UserInputService = game:GetService('UserInputService')
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local Players = game:GetService('Players')

-- modules
local keybinds = require(ReplicatedStorage.Components.Keybinds)

-- Data
local localPlayer = Players.LocalPlayer
local Observables = localPlayer:WaitForChild("Observables")

local SetStateValue = ReplicatedStorage.Events.SetStateValue
local generalKeys = keybinds.GeneralKeys

UserInputService.InputBegan:Connect(function(anInputObject, isTyping)
    if anInputObject.KeyCode == generalKeys.B and not isTyping then
        SetStateValue:FireServer()
    end
end)





