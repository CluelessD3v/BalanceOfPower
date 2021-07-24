local Players = game:GetService('Players')
local localPlayer = Players.LocalPlayer
local dataFolder = localPlayer:WaitForChild("Data")


local inBuildMode = dataFolder:WaitForChild("InBuildMode")

local mouse = Players.LocalPlayer:GetMouse()
inBuildMode.Changed:Connect(function(theValue)
    if theValue then
        -- call building system logic here
    end

    
end)