-------------------- Services --------------------
local Players = game:GetService('Players')
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local UserInputService = game:GetService('UserInputService')
local ContextActionService = game:GetService('ContextActionService')

-------------------- Systems --------------------
local ConstructionSystemClass = require(ReplicatedStorage.Systems.ConstructionSystem.ConstructionSystemClass)
local BuildingClass = require(ReplicatedStorage.Systems.ConstructionSystem.BuildingClass)
-------------------- Components --------------------
local BuildingsComponent = require(ReplicatedStorage.Components.ConstructionSystemComponents.BuildingsComponent)

-------------------- Utilities --------------------
local GuiUtility = require(ReplicatedStorage.Systems.GuiUtility)
local Keybinds = require(ReplicatedStorage.Components.Keybinds)
local MouseCasterLib = require(ReplicatedStorage.Utilities.MouseCaster)
local MouseFilterComponent = require(ReplicatedStorage.Components.ConstructionSystemComponents.MouseFilterComponent)
-------------------- Data --------------------
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

local MouseCaster = MouseCasterLib.new()
MouseCaster:SetTargetFilter({localPlayer.Character, workspace.Baseplate, workspace.SpawnLocation})
MouseCaster:UpdateTargetFilterFromTags(MouseFilterComponent[1])


local SetBuildMode = ReplicatedStorage.Remotes.Events.SetBuildMode
local newConstructionSystem = {} --> initializing as empty table cause you cannot index things to nil

local testAssets = BuildingsComponent.TestAssets

--//TODO FIXCON3 This still weirds me out a bit... Having this local function here is kinda weird
--> when a building button is clicked, a new construction system object is instanced
local function onBuildingButtonClicked(aBuildingButton: GuiButton,  aBuildingComponent: table)
    if aBuildingComponent.ExtraData.GameObject == nil then
        warn("No building game object was set, defaulting to BasePart")
        aBuildingComponent.ExtraData.GameObject = Instance.new("Part")
    end
    
    aBuildingButton.MouseButton1Click:Connect(function()
        BuildingsPanel.Visible = not BuildingsPanel.Visible 

        -- since the construction system class is destroyed, we need to re-initialize it
        if newConstructionSystem.Enabled == nil then
            newConstructionSystem = ConstructionSystemClass.new(MouseCaster,  MouseFilterComponent[2])
        end

        --local buildingEntity = BuildingClass.new(aBuildingGameObject)

        newConstructionSystem:Init(aBuildingComponent, SetBuildMode) --> This would be "BuildingAssets"
        newConstructionSystem:PreviewBuilding()
        newConstructionSystem:ExitBuildMode(generalKeys.X, SetBuildMode)
    end)
end

local buttons = { -->//TODO FIXCON3 Move this to a Gui buttons component
    BuildingsPanel.RedBuildingButton,
    BuildingsPanel.YellowBuildingButton,
    BuildingsPanel.BlueBuildingButton,   
    BuildingsPanel.GreenBuildingButton,
}

for i = 1,  4 do -->//TODO FIXCON3 Make this loop accept n buttons
    onBuildingButtonClicked(buttons[i], testAssets[i])
end



