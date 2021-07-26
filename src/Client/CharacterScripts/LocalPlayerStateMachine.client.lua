local Players = game:GetService('Players')
local localPlayer = Players.LocalPlayer
local dataFolder = localPlayer:WaitForChild("Data")
local RunService = game:GetService('RunService')
local CollectionService = game:GetService('CollectionService')
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local Building = require(ReplicatedStorage.Systems.BuildingEntity)



local inBuildMode = dataFolder:WaitForChild("InBuildMode")

local mouse = Players.LocalPlayer:GetMouse()

local whiteListFilter = {"Tile", "UsableLand"}
local part = workspace.TestingPart

local newBuilding = nil
inBuildMode.Changed:Connect(function(InBuildMode)
    if InBuildMode then
        newBuilding = Building.new(part, whiteListFilter, mouse)
        newBuilding:PreviewBuilding()
    else

        newBuilding:Destroy()
    end
end)