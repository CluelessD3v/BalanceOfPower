-- Services
local UserInputService = game:GetService('UserInputService')
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local Players = game:GetService('Players')
local CollectionService = game:GetService('CollectionService')
local RunService = game:GetService('RunService')

-- modules

-- Data
local player = Players.LocalPlayer
local playerValues = player:WaitForChild("Values")
local mouse = Players.LocalPlayer:GetMouse()


UserInputService.InputBegan:Connect(function(anInputObject, isTyping)
    if anInputObject.KeyCode == Enum.KeyCode.E and not isTyping then
        print(anInputObject.KeyCode)
    end

end)