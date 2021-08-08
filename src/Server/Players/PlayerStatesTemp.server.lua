local ReplicatedStorage = game:GetService('ReplicatedStorage')
local SetStateValue : RemoteEvent = ReplicatedStorage.Remotes.Events.SetStateToBuildModeEvent
--//TODO check into making this accept any bool obj val and to flip that
SetStateValue.OnServerEvent:Connect(function(player)
    print("Event Catched")
    local inBuildMode : StringValue = player.Data.States.InBuildMode
    inBuildMode.Value = not inBuildMode.Value --//TODO make a module with all possible states
end)