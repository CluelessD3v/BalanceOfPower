local Players = game:GetService('Players')

--//TODO HIDE FACE DECAL AS WELL
Players.PlayerAdded:Connect(function(aPlayer)
    aPlayer.CameraMinZoomDistance = 500
    aPlayer.CharacterAdded:Connect(function(aCharacter)
        aCharacter.Humanoid.WalkSpeed = 150
    end)
end)