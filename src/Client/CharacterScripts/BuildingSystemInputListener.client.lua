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

local part = workspace.TestingPart
local mouse = Players.LocalPlayer:GetMouse()
local whiteListFilter = {"Tile", "UsableLand"}

local newConstructionSystem = nil


local localPlayer = Players.LocalPlayer
local Gui = localPlayer:WaitForChild("PlayerGui")
local PanelsGui = Gui.PanelsGui
local BuildingsPanel = PanelsGui.BuildingsPanel

UserInputService.InputBegan:Connect(function(anInputObject, isTyping)
    if anInputObject.KeyCode == generalKeys.B and not isTyping then
        BuildingsPanel.Visible = not BuildingsPanel.Visible
    end
end)




--[[
local function BindAction(actionName, inputState)
    if actionName == "InBuildMode" then
        if inputState == Enum.UserInputState.Begin then
            print("Click")
        end
    end
end

local SetBuildMode: RemoteFunction = ReplicatedStorage.Remotes.Functions.SetBuildMode

UserInputService.InputBegan:Connect(function(anInputObject, isTyping)
    if anInputObject.KeyCode == generalKeys.B and not isTyping then
        local inBuildMode = SetBuildMode:InvokeServer()
        
        if inBuildMode then
            print("True")
            ContextActionService:BindAction("InBuildMode", BindAction, false, Enum.UserInputType.MouseButton1)
            
            newConstructionSystem = ConstructionSystem.new(part, mouse, whiteListFilter)
            newConstructionSystem:PreviewBuilding()     
        elseif not inBuildMode then
            print("false")
            ContextActionService:UnbindAction("InBuildMode")
            newConstructionSystem:Destroy()
        end
    end
end)
--]]




