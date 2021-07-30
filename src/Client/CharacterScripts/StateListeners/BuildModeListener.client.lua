--[[
    this script listens for the player state to be changed to BuildMode to start Building system routines

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
local ConstructionSystem = require(ReplicatedStorage.Systems.ConstructionSystem.ConstructionSystemEntity)
local keybinds = require(ReplicatedStorage.Components.Keybinds)

-- Data
local localPlayer = Players.LocalPlayer
local part = workspace.TestingPart
local mouse = Players.LocalPlayer:GetMouse()
local whiteListFilter = {"Tile", "UsableLand"}

local generalKeys = keybinds.GeneralKeys


local function BindAction(actionName, inputState)
    if inputState == Enum.UserInputState.Begin then
        print("click")
    end
end

function ExitBuildMode(anInputObject, isTyping)
    local SetBuildMode: RemoteFunction = ReplicatedStorage.Remotes.Functions.SetBuildMode
    if anInputObject.KeyCode == generalKeys.X and not isTyping then
        print("Out")
        SetBuildMode:InvokeServer()
    end
end


local newConstructionSystem = nil
local exitConnection = nil
local state = localPlayer.Data.States.InBuildMode

state.Changed:Connect(function(inBuildMode)
    if inBuildMode then
        ContextActionService:BindAction("InBuildMode", BindAction, false, generalKeys.LMB)
        newConstructionSystem = ConstructionSystem.new(part, mouse, whiteListFilter)
        newConstructionSystem:PreviewBuilding()
        exitConnection = UserInputService.InputBegan:Connect(ExitBuildMode)
    else
        ContextActionService:UnbindAction("InBuildMode")
        newConstructionSystem:Destroy()

        exitConnection:Disconnect()
    end
end)




