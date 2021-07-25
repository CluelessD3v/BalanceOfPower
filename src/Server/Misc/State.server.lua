local ReplicatedStorage = game:GetService('ReplicatedStorage')
local SetStateValue = ReplicatedStorage.Events.SetStateValue


SetStateValue.OnServerEvent:Connect(function(aPlayer)
    local inBuildMode = aPlayer.Data.InBuildMode
    inBuildMode.Value = not inBuildMode.Value
end)