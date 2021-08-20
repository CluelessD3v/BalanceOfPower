-------------------- Services --------------------
local Players = game:GetService('Players')
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local UserInputService = game:GetService('UserInputService')
local ContextActionService = game:GetService('ContextActionService')

-------------------- Modules --------------------
local keybinds = require(ReplicatedStorage.Components.Keybinds)


local localPlayer = Players.LocalPlayer
local Gui = localPlayer:WaitForChild("PlayerGui")


-------------------- Top level instances --------------------

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
local tagsBlacklist = {"Asset", "Player"} --> //TODO FIXCON2 This must be put in replicated storage as a component

local ConstructionSystemEntity = require(ReplicatedStorage.Systems.ConstructionSystem.ConstructionSystemEntity)
local MouseCasterLib = require(ReplicatedStorage.Utilities.MouseCaster)

local MouseCaster = MouseCasterLib.new()
MouseCaster:UpdateTargetFilterFromTags(tagsBlacklist)

local SetBuildMode = ReplicatedStorage.Remotes.Events.SetBuildMode

-- prevents new instances from appearing when clicking a building button WHILE not having disposed of the class instance
local newConstructionSystem = {} --> initializing as empty table cause you cannot index things to nil

-->FIXCON3: refactor this to avoid so much code repetition
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
 
     newConstructionSystem:Init(workspace.Yellow, mouse, whiteListFilter, SetBuildMode)
    newConstructionSystem:PreviewBuilding()
    newConstructionSystem:ExitBuildMode(generalKeys.X, SetBuildMode) 
end)

local greenBuildingButton: ImageButton = BuildingsPanel.GreenBuildingButton

greenBuildingButton.MouseButton1Click:Connect(function()
    BuildingsPanel.Visible = not BuildingsPanel.Visible

    if newConstructionSystem.Enabled == nil then
        newConstructionSystem = ConstructionSystemEntity.new()
    end

    newConstructionSystem:Init(workspace.Green, mouse, whiteListFilter, SetBuildMode) 
    newConstructionSystem:PreviewBuilding()
    newConstructionSystem:ExitBuildMode(generalKeys.X, SetBuildMode)
end)


local blueBuildingButton: ImageButton = BuildingsPanel.BlueBuildingButton

blueBuildingButton.MouseButton1Click:Connect(function()
    BuildingsPanel.Visible = not BuildingsPanel.Visible

    if newConstructionSystem.Enabled == nil then
        newConstructionSystem = ConstructionSystemEntity.new()
    end

    newConstructionSystem:Init(workspace.Blue, mouse, whiteListFilter, SetBuildMode)
    newConstructionSystem:PreviewBuilding()
    newConstructionSystem:ExitBuildMode(generalKeys.X, SetBuildMode) 
end)

