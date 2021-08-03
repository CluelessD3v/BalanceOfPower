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
local SetBuildMode: RemoteEvent = ReplicatedStorage.Remotes.Events.SetBuildMode

    

