-- Services
local UserInputService = game:GetService('UserInputService')
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local Players = game:GetService('Players')
local CollectionService = game:GetService('CollectionService')

-- modules

-- Data
local localPlayer = Players.LocalPlayer
local dataFolder = localPlayer:WaitForChild("Data")

local SetStateValue = ReplicatedStorage.Events.SetStateValue

UserInputService.InputBegan:Connect(function(anInputObject, isTyping)
    if anInputObject.KeyCode == Enum.KeyCode.E and not isTyping then
        SetStateValue:FireServer()
    end
end)





