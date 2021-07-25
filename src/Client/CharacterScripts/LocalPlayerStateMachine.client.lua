local Players = game:GetService('Players')
local localPlayer = Players.LocalPlayer
local dataFolder = localPlayer:WaitForChild("Data")
local RunService = game:GetService('RunService')
local CollectionService = game:GetService('CollectionService')




local inBuildMode = dataFolder:WaitForChild("InBuildMode")

local mouse = Players.LocalPlayer:GetMouse()

local connection = nil
local part = nil
local whiteListFilter = {"Tile", "UsableLand"}
inBuildMode.Changed:Connect(function(theValue)
    
    if theValue then
        part = workspace.TestingPart:Clone()
        part.Anchored = true
        part.CanCollide = false
        part.Parent = workspace
        
        connection = RunService.Heartbeat:Connect(function()
            
            if mouse.Target == nil  then return end
            for _, tag in ipairs(whiteListFilter) do
                print(tag)
                if not CollectionService:HasTag(mouse.Target, tag) then
                    return
                end
            end
            

            print(mouse.Target)
            part.Position = mouse.Target.Position + Vector3.new(0,10,0) 
        end)
    else
        part:Destroy()
        connection:Disconnect()
    end
end)