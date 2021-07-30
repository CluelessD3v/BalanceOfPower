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
local button: ImageButton = PanelsGui.PanelButtons.BuildingPanelButton
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


-------------------- BuildMode state Setters --------------------
local testBuildingButton: ImageButton = BuildingsPanel.TestBuildingButton


local SetBuildMode: RemoteFunction = ReplicatedStorage.Remotes.Functions.SetBuildMode
-- Change state to "InBuildMode" and hide the buildings panel for a non obstructed view
testBuildingButton.MouseButton1Click:Connect(function()
    SetBuildMode:InvokeServer()
    BuildingsPanel.Visible = not BuildingsPanel.Visible
end)
    

