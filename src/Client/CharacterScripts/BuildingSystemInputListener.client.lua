-- Services
local UserInputService = game:GetService('UserInputService')
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local Players = game:GetService('Players')

-- modules
local keybinds = require(ReplicatedStorage.Components.Keybinds)

-- Data
local localPlayer = Players.LocalPlayer
local Observables = localPlayer:WaitForChild("Observables")


local generalKeys = keybinds.GeneralKeys
local SetBuildMode: RemoteFunction = ReplicatedStorage.Remotes.Functions.SetBuildMode



local Building = require(ReplicatedStorage.Systems.BuildingEntity)



local ContextActionService = game:GetService('ContextActionService')


local mouse = Players.LocalPlayer:GetMouse()

local whiteListFilter = {"Tile", "UsableLand"}
local part = workspace.TestingPart

local newBuilding = nil

local function BindAction(actionName, inputState)
    if actionName == "InBuildMode" then
        if inputState == Enum.UserInputState.Begin then
            print("Click")
        end
    end
end




UserInputService.InputBegan:Connect(function(anInputObject, isTyping)
    if anInputObject.KeyCode == generalKeys.B and not isTyping then
        local inBuildMode = SetBuildMode:InvokeServer()
        if inBuildMode then
            print("True")
            ContextActionService:BindAction("InBuildMode", BindAction, false, Enum.UserInputType.MouseButton1)
            newBuilding = Building.new(part, whiteListFilter, mouse)
            newBuilding:PreviewBuilding()
        elseif not inBuildMode then
            print("false")
            ContextActionService:UnbindAction("InBuildMode")
            newBuilding:Destroy()
        end
    end
end)





