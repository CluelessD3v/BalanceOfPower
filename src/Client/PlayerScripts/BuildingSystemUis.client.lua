-- Services
local UserInputService = game:GetService('UserInputService')
local RunService = game:GetService('RunService')
local Players = game:GetService('Players')

-- Data
local Mouse = Players.LocalPlayer:GetMouse()
print(Mouse)

--[[RunService.Heartbeat:Connect(function()
    print(Mouse.Target) 
end)]]--

local function StartBuildMode()
    local p = Instance.new("Part")
    p.CanCollide = false
    p.Anchored = true
    p.Parent = workspace
    p.Size = Vector3.new(10, 2, 10)
    p.BrickColor = BrickColor.new("Really red")
    
    Mouse.TargetFilter = p

    RunService.Heartbeat:Connect(function()
        p.Position = Mouse.Target.Position + Vector3.new(0, 1, 0)
    end)
end


UserInputService.InputBegan:Connect(function(anInput)
    if anInput.KeyCode == Enum.KeyCode.E then
        StartBuildMode()
    end
end)