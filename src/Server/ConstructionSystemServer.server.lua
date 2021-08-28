local ReplicatedStorage = game:GetService('ReplicatedStorage')
local SetBuildMode : RemoteEvent = ReplicatedStorage.Remotes.Events.SetBuildMode

SetBuildMode.OnServerEvent:Connect(function(player, value, constructionSystem)
    local inBuildMode = player.Data.States.InBuildMode
    inBuildMode.Value = value
end)