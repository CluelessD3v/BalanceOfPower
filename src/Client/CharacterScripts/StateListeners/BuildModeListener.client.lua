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

local mouse = Players.LocalPlayer:GetMouse()
local whiteListFilter = {"Tile", "UsableLand"}

local generalKeys = keybinds.GeneralKeys


--[[
local inBuildModeObjVal: BoolValue = localPlayer.Data.States.InBuildMode
local SetBuildMode: RemoteFunction = ReplicatedStorage.Remotes.Functions.SetStateToBuildModeEvent

local newConstructionSystem = nil

inBuildModeObjVal.Changed:Connect(function(inBuildMode)
    print("Build mode state is now", inBuildMode)

    if inBuildMode then
        print("true")

        newConstructionSystem = ConstructionSystem.new(workspace.Red, mouse, whiteListFilter)        
        newConstructionSystem:PreviewBuilding()

        -- Since Lua has no variable hoisting, I am forced to do this ;-;        
        local function BindToBuildMode(_, inputState, _)
            if inputState == Enum.UserInputState.Begin then                
                newConstructionSystem:PlacePrefab()
                SetBuildMode:InvokeServer()
            end
        end

        ContextActionService:BindAction("InBuildMode", BindToBuildMode, false, generalKeys.LMB)
        newConstructionSystem:ExitBuildMode(SetBuildMode, generalKeys.X)
    else
        ContextActionService:UnbindAction("InBuildMode")
        newConstructionSystem:Destroy()
    end
end)

--]]




