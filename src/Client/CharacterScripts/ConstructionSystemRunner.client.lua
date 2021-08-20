-------------------- Services --------------------
local Players = game:GetService('Players')
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local UserInputService = game:GetService('UserInputService')
local ContextActionService = game:GetService('ContextActionService')

-------------------- Modules --------------------
local GuiUtility = require(ReplicatedStorage.Systems.GuiUtility)
local keybinds = require(ReplicatedStorage.Components.Keybinds)

-------------------- Top level instances --------------------
local localPlayer = Players.LocalPlayer
local Gui = localPlayer:WaitForChild("PlayerGui")

local PanelsGui = Gui.PanelsGui
local buildingsPanelbutton: ImageButton = PanelsGui.ButtonsPanel.BuildingsPanelButton
local BuildingsPanel = PanelsGui.BuildingsPanel

-------------------- Panel visible via Gui --------------------

GuiUtility.OnGuiButtonSetGuiVisibility(buildingsPanelbutton, BuildingsPanel)

local generalKeys = keybinds.GeneralKeys
GuiUtility.OnKeySetGuiVisibility(generalKeys.B, BuildingsPanel)

--------------------------------------------------------------------------------------------------------------
local mouse = Players.LocalPlayer:GetMouse()
local tagsBlacklist = {"Asset", "Player"} --> //TODO FIXCON2 This must be put in replicated storage as a component

local ConstructionSystemEntity = require(ReplicatedStorage.Systems.ConstructionSystem.ConstructionSystemEntity)
local MouseCasterLib = require(ReplicatedStorage.Utilities.MouseCaster)


local MouseCaster = MouseCasterLib.new()
MouseCaster:UpdateTargetFilterFromTags(tagsBlacklist)
local SetBuildMode = ReplicatedStorage.Remotes.Events.SetBuildMode

local newConstructionSystem = {} --> initializing as empty table cause you cannot index things to nil

local redBuildingButton: ImageButton = BuildingsPanel.RedBuildingButton

redBuildingButton.MouseButton1Click:Connect(function()
    BuildingsPanel.Visible = not BuildingsPanel.Visible

    if newConstructionSystem.Enabled == nil then
        newConstructionSystem = ConstructionSystemEntity.new()
    end

    newConstructionSystem:Init(workspace.Red, MouseCaster, SetBuildMode) 
    newConstructionSystem:PreviewBuilding()
    newConstructionSystem:ExitBuildMode(generalKeys.X, SetBuildMode)
end)


local yellowBuildingButton: ImageButton = BuildingsPanel.YellowBuildingButton

yellowBuildingButton.MouseButton1Click:Connect(function()
    BuildingsPanel.Visible = not BuildingsPanel.Visible

    if newConstructionSystem.Enabled == nil then
        newConstructionSystem = ConstructionSystemEntity.new()
    end
 
     newConstructionSystem:Init(workspace.Yellow, MouseCaster, SetBuildMode)
    newConstructionSystem:PreviewBuilding()
    newConstructionSystem:ExitBuildMode(generalKeys.X, SetBuildMode) 
end)

local greenBuildingButton: ImageButton = BuildingsPanel.GreenBuildingButton

greenBuildingButton.MouseButton1Click:Connect(function()
    BuildingsPanel.Visible = not BuildingsPanel.Visible

    if newConstructionSystem.Enabled == nil then
        newConstructionSystem = ConstructionSystemEntity.new()
    end

    newConstructionSystem:Init(workspace.Green, MouseCaster, SetBuildMode) 
    newConstructionSystem:PreviewBuilding()
    newConstructionSystem:ExitBuildMode(generalKeys.X, SetBuildMode)
end)


local blueBuildingButton: ImageButton = BuildingsPanel.BlueBuildingButton

blueBuildingButton.MouseButton1Click:Connect(function()
    BuildingsPanel.Visible = not BuildingsPanel.Visible

    if newConstructionSystem.Enabled == nil then
        newConstructionSystem = ConstructionSystemEntity.new()
    end

    newConstructionSystem:Init(workspace.Blue, MouseCaster, SetBuildMode)
    newConstructionSystem:PreviewBuilding()
    newConstructionSystem:ExitBuildMode(generalKeys.X, SetBuildMode) 
end)

