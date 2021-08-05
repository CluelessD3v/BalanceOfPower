local ReplicatedStorage = game:GetService('ReplicatedStorage')
local SetBuildMode : RemoteEvent = ReplicatedStorage.Remotes.Events.SetBuildMode

SetBuildMode.OnServerEvent:Connect(function(player)
    local inBuildMode = player.Data.States.InBuildMode
    inBuildMode.Value = not inBuildMode.Value
end)