local Players = game:GetService('Players')

--//TODO HIDE FACE DECAL AS WELL
Players.PlayerAdded:Connect(function(aPlayer)
    aPlayer.CharacterAdded:Connect(function(aCharacter)
        aCharacter.Humanoid.WalkSpeed = 100 --//TODO move this somewere else
        wait(3)
        print(aCharacter.Head:IsA("BasePart"))
        for _, child in pairs(aCharacter:GetDescendants()) do
            
            if child:IsA("MeshPart") or child:IsA("BasePart")then
                child.Transparency = 1
            end

        end
    end)
end)