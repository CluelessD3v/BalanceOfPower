local Players = game:GetService('Players')
local RunService = game:GetService('RunService')
local CollectionService = game:GetService('CollectionService')
local ReplicatedStorage = game:GetService('ReplicatedStorage')

--[[
local Building = require(ReplicatedStorage.Systems.BuildingEntity)

local localPlayer = Players.LocalPlayer
local Observables = localPlayer:WaitForChild("Observables")

local ContextActionService = game:GetService('ContextActionService')

local inBuildMode = Observables:WaitForChild("InBuildMode")

local mouse = Players.LocalPlayer:GetMouse()

local whiteListFilter = {"Tile", "UsableLand"}
local part = workspace.TestingPart

local newBuilding = nil

local function BindAction(actionName, inputState)
    if actionName == "InBuildMode" then
        if inputState == Enum.UserInputState.Begin then
            print("Click")
        end
    end
end


inBuildMode.Changed:Connect(function(InBuildMode)
    if InBuildMode then
        print("true")
        ContextActionService:BindAction("InBuildMode", BindAction, false, Enum.UserInputType.MouseButton1)
        newBuilding = Building.new(part, whiteListFilter, mouse)
        newBuilding:PreviewBuilding()
    else
        ContextActionService:UnbindAction("InBuildMode")
        newBuilding:Destroy()
    end
end)--]]