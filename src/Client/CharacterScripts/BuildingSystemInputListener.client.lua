--[[
    This script sends input signals to the server to flip observable states in the player data folder via remote functions.
    It follows a personal flavour of the observer pattern.

    | sends Input                     |Changes state of an 
            &                          observable on invoked
      Observes state                
    Client ----------------------------- Server
]]--

-- Services
local UserInputService = game:GetService('UserInputService')
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local Players = game:GetService('Players')
local ContextActionService = game:GetService('ContextActionService')

-- modules
local keybinds = require(ReplicatedStorage.Components.Keybinds)
local ConstructionSystem = require(ReplicatedStorage.Systems.ConstructionSystem.ConstructionSystemEntity)

-- Data
local generalKeys = keybinds.GeneralKeys
local SetBuildMode: RemoteFunction = ReplicatedStorage.Remotes.Functions.SetBuildMode
local mouse = Players.LocalPlayer:GetMouse()

local whiteListFilter = {"Tile", "UsableLand"}
local part = workspace.TestingPart

local newConstructionSystem = nil

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
            newConstructionSystem = ConstructionSystem:PreviewBuilding(part, mouse,  whiteListFilter)            
        elseif not inBuildMode then
            print("false")
            ContextActionService:UnbindAction("InBuildMode")
            newConstructionSystem:Destroy()
        end
    end
end)





