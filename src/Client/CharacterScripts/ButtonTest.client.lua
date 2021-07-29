local Players = game:GetService('Players')
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local ContextActionService = game:GetService('ContextActionService')


local localPlayer = Players.LocalPlayer
local Gui = localPlayer:WaitForChild("PlayerGui")

local PanelsGui = Gui.PanelsGui
local button: ImageButton = PanelsGui.PanelButtons.BuildingPanelButton
local BuildingsPanel = PanelsGui.BuildingsPanel

button.MouseButton1Click:Connect(function()
    BuildingsPanel.Visible = not BuildingsPanel.Visible
end)
