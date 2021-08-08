local Players = game:GetService('Players')

--//TODO FIXCON4 make this variable, normal camera speed, and when shift is pressed to start running
Players.PlayerAdded:Connect(function(aPlayer)
    aPlayer.CameraMinZoomDistance = 500
    aPlayer.CharacterAdded:Connect(function(aCharacter)
        aCharacter.Humanoid.WalkSpeed = 150
    end)
end)