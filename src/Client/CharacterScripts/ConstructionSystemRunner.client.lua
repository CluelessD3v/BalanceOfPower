-------------------- Services --------------------
local Players = game:GetService('Players')
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local UserInputService = game:GetService('UserInputService')
local ContextActionService = game:GetService('ContextActionService')

-------------------- Modules --------------------
local GuiUtility = require(ReplicatedStorage.Systems.GuiUtility)
local Keybinds = require(ReplicatedStorage.Components.Keybinds)
local BuildingsComponent = require(ReplicatedStorage.Components.BuildingsComponent)

-------------------- Top level instances --------------------
local localPlayer = Players.LocalPlayer
local Gui = localPlayer:WaitForChild("PlayerGui")

local PanelsGui: ScreenGui = Gui.PanelsGui
local buildingsPanelbutton: ImageButton = PanelsGui.ButtonsPanel.BuildingsPanelButton
local BuildingsPanel: Framel = PanelsGui.BuildingsPanel

-------------------- Panel visible via Gui --------------------

GuiUtility.OnGuiButtonSetGuiVisibility(buildingsPanelbutton, BuildingsPanel)

local generalKeys = Keybinds.GeneralKeys
GuiUtility.OnKeySetGuiVisibility(generalKeys.B, BuildingsPanel)

--------------------------------------------------------------------------------------------------------------
local tagsBlacklist = {"Asset", "Player"} --> //TODO FIXCON2 This must be put in replicated storage as a component

local ConstructionSystemEntity = require(ReplicatedStorage.Systems.ConstructionSystem.ConstructionSystemEntity)
local MouseCasterLib = require(ReplicatedStorage.Utilities.MouseCaster)


local MouseCaster = MouseCasterLib.new()
MouseCaster:SetTargetFilter({localPlayer.Character, workspace.Baseplate, workspace.SpawnLocation})
local SetBuildMode = ReplicatedStorage.Remotes.Events.SetBuildMode

local newConstructionSystem = {} --> initializing as empty table cause you cannot index things to nil

--//TODO FIXCON3 This still weirds me out a bit... Having this local function here is kinda weird
--> when a building button is clicked, call this
local function onBuildingButtonClicked(aBuildingButton: GuiButton, buildingInstance)
    aBuildingButton.MouseButton1Click:Connect(function()
        BuildingsPanel.Visible = not BuildingsPanel.Visible

        if newConstructionSystem.Enabled == nil then
            newConstructionSystem = ConstructionSystemEntity.new()
        end

        newConstructionSystem:Init(buildingInstance, MouseCaster, SetBuildMode, tagsBlacklist) 
        newConstructionSystem:PreviewBuilding()
        newConstructionSystem:ExitBuildMode(generalKeys.X, SetBuildMode)
    end)
end

local testAssets = BuildingsComponent.TestAssets

onBuildingButtonClicked(BuildingsPanel.RedBuildingButton, testAssets.Red.ExtraData.GameObject)
onBuildingButtonClicked(BuildingsPanel.GreenBuildingButton, testAssets.Green.ExtraData.GameObject)
onBuildingButtonClicked(BuildingsPanel.YellowBuildingButton, testAssets.Yellow.ExtraData.GameObject)
onBuildingButtonClicked(BuildingsPanel.BlueBuildingButton, testAssets.Blue.ExtraData.GameObject)


