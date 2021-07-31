local Players = game:GetService("Players")

local song = game.ReplicatedStorage.HeboFratermanHavanaCity
game.Players.PlayerAdded:Connect(function()
    song:Play()
end)