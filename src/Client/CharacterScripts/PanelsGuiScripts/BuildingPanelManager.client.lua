-------------------- Services --------------------
local Players = game:GetService('Players')
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local UserInputService = game:GetService('UserInputService')
local ContextActionService = game:GetService('ContextActionService')

-------------------- Modules --------------------
local keybinds = require(ReplicatedStorage.Components.Keybinds)


local localPlayer = Players.LocalPlayer
local Gui = localPlayer:WaitForChild("PlayerGui")

local PanelsGui = Gui.PanelsGui
local button: ImageButton = PanelsGui.ButtonsPanel.BuildingsPanelButton
local BuildingsPanel = PanelsGui.BuildingsPanel



-------------------- Panel visible via Gui --------------------
--[[
    Binding panel visibility to gui image button
]]--

button.MouseButton1Click:Connect(function()
    BuildingsPanel.Visible = not BuildingsPanel.Visible
end)


-------------------- Panel visible via UserInput --------------------
--[[
    Binding panel visibility to a keyboard key
]]
local generalKeys = keybinds.GeneralKeys
UserInputService.InputBegan:Connect(function(anInputObject, isTyping)
    if anInputObject.KeyCode == generalKeys.B and not isTyping then
        BuildingsPanel.Visible = not BuildingsPanel.Visible
    end
end)


--------------------------------------------------------------------------------------------------------------
local RedBuildingButton: ImageButton = BuildingsPanel.RedBuildingButton


local selectedBuilding = nil
local SetBuildMode: RemoteEvent = ReplicatedStorage.Remotes.Events.SetBuildMode

    
local mouse = Players.LocalPlayer:GetMouse()
local whiteListFilter = {"Tile", "UsableLand"}

local inBuildModeObjVal: BoolValue = localPlayer.Data.States.InBuildMode
local newConstructionSystem = nil
local ConstructionSystem = require(ReplicatedStorage.Systems.ConstructionSystem.ConstructionSystemEntity)



RedBuildingButton.MouseButton1Click:Connect(function() --> functionnify this into the module
    selectedBuilding = workspace.Red --> put this hardcoded buildings in a module 
    SetBuildMode:FireServer()
    BuildingsPanel.Visible = not BuildingsPanel.Visible
end)






inBuildModeObjVal.Changed:Connect(function(inBuildMode)
    print("Build mode state is now", inBuildMode)

    if inBuildMode then
        newConstructionSystem = ConstructionSystem.new(selectedBuilding, mouse, whiteListFilter)        
        newConstructionSystem:PreviewBuilding()

        -- Since Lua has no variable hoisting, I am forced to do this ;-;        
        local function BindToBuildMode(_, inputState, _)
            if inputState == Enum.UserInputState.Begin then                
                newConstructionSystem:PlacePrefab()
                SetBuildMode:FireServer()
            end
        end

        ContextActionService:BindAction("InBuildMode", BindToBuildMode, false, generalKeys.LMB)
        newConstructionSystem:ExitBuildMode(SetBuildMode, generalKeys.X)
    else
        ContextActionService:UnbindAction("InBuildMode")
        newConstructionSystem:Destroy()
    end
end)
