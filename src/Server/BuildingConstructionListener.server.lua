local ReplicatedStorage = game:GetService('ReplicatedStorage')
local BuildableEntity = require(ReplicatedStorage.Components.BuildableEntity)
local CollectionService = game:GetService('CollectionService')

local PreviewBuildingEvent = ReplicatedStorage.Events.PreviewBuildingEvent


PreviewBuildingEvent.OnServerEvent:Connect(function(player, aTarget: Instance)
    player.Values.SelectedObject.Value = nil
end)
