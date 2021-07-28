local ReplicatedStorage = game:GetService('ReplicatedStorage')
local SetStateValue = ReplicatedStorage.Remotes.Functions.SetBuildMode

--[[
SetStateValue.OnServerEvent:Connect(function(aPlayer)
    local inBuildMode = aPlayer.Observables.InBuildMode
    inBuildMode.Value = not inBuildMode.Value
end)
--]]
SetStateValue.OnServerInvoke = function(aPlayer)
    local inBuildMode = aPlayer.Observables.InBuildMode
    inBuildMode.Value = not inBuildMode.Value
    return inBuildMode.Value
end