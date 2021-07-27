-- Services
local UserInputService = game:GetService('UserInputService')
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local Players = game:GetService('Players')
local ContextActionService = game:GetService('ContextActionService')

-- modules

-- Data
local localPlayer = Players.LocalPlayer
local dataFolder = localPlayer:WaitForChild("Data")

local SetStateValue = ReplicatedStorage.Events.SetStateValue

local buildingModeAction = "BuildingMode"





local function BA(actionName, inputState)
    if actionName == buildingModeAction then
        if inputState == Enum.UserInputState.Begin then
            print("click")
        end
    end    
end


UserInputService.InputBegan:Connect(function(anInputObject, isTyping)
    if anInputObject.KeyCode == Enum.KeyCode.B and not isTyping then
        SetStateValue:FireServer()
        ContextActionService:BindAction(buildingModeAction, BA, false, Enum.UserInputType.MouseButton1)

    end
end)





