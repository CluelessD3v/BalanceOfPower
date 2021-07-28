local ReplicatedStorage = game:GetService('ReplicatedStorage')
local SetStateValue = ReplicatedStorage.Remotes.Functions.SetBuildMode

SetStateValue.OnServerInvoke = function(aPlayer)
    local inBuildMode = aPlayer.Data.States.InBuildMode
    inBuildMode.Value = not inBuildMode.Value
    return inBuildMode.Value
end