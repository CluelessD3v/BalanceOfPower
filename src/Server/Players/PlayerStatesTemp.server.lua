local ReplicatedStorage = game:GetService('ReplicatedStorage')
local SetBuildMode : RemoteEvent = ReplicatedStorage.Remotes.Events.SetBuildMode
--local SetSelectedObject : RemoteEvent = ReplicatedStorage.Remotes.Events.SettSelectedObject

--//TODO check into making this accept any bool obj val and to flip that
SetBuildMode.OnServerEvent:Connect(function(player : player)
    print("Event Catched")
    local inBuildMode : BoolValue = player.Data.States.InBuildMode
    inBuildMode.Value = not inBuildMode.Value --//TODO make a module with all possible states
end)



-- SetBuildMode.OnServerInvoke = function(player : player)
--     print("Function Invoked")
--     local inBuildMode : BoolValue = player.Data.States.InBuildMode
--     inBuildMode.Value = not inBuildMode.Value
--     return inBuildMode.Value 
-- end 
