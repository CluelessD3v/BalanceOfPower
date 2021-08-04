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
local buildingsPanelbutton: ImageButton = PanelsGui.ButtonsPanel.BuildingsPanelButton
local BuildingsPanel = PanelsGui.BuildingsPanel



-------------------- Panel visible via Gui --------------------
--[[
    Binding panel visibility to gui image button
]]--

buildingsPanelbutton.MouseButton1Click:Connect(function()
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
local mouse = Players.LocalPlayer:GetMouse()
local whiteListFilter = {"Tile", "UsableLand"}

local ConstructionSystemEntity = require(ReplicatedStorage.Systems.ConstructionSystem.ConstructionSystemEntity)


local redBuildingButton: ImageButton = BuildingsPanel.RedBuildingButton
local SetBuildMode: RemoteEvent = ReplicatedStorage.Remotes.Events.SetBuildMode
local ibm = false
-- prevents new instances from appearing when clicking a building button WHILE not having disposed of the class instance
local newConstructionSystem = ConstructionSystemEntity.new() 

redBuildingButton.MouseButton1Click:Connect(function()
    BuildingsPanel.Visible = not BuildingsPanel.Visible



    newConstructionSystem:Init(workspace.Red, mouse, whiteListFilter, SetBuildMode)
    newConstructionSystem:PreviewBuilding()
    newConstructionSystem:ExitBuildMode(generalKeys.X, SetBuildMode)

 
end)

local yellowBuildingButton: ImageButton = BuildingsPanel.YellowBuildingButton

    yellowBuildingButton.MouseButton1Click:Connect(function()
    BuildingsPanel.Visible = not BuildingsPanel.Visible
    newConstructionSystem:Init(workspace.Yellow, mouse, whiteListFilter)
    newConstructionSystem:PreviewBuilding()
    newConstructionSystem:ExitBuildMode(generalKeys.X, SetBuildMode) 
end)
