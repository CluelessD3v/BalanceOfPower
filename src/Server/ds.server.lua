--The game is required to be public for data saves to work
local dataStorage = game:GetService("DataStoreService")
local dataStore = dataStorage:GetDataStore("dataStore") --GetDataStorage get's data from a store by a name

game.Players.PlayerAdded:Connect(function(player)
    local leaderstats = Instance.new("Folder")
    leaderstats.Name = "leaderstats"
    leaderstats.Parent = player
    
    local Moners = Instance.new("IntValue")
    Moners.Name = "Moners"
    Moners.Parent = leaderstats
    
    local Stuff = Instance.new("IntValue")
    Stuff.Name = "Stuff"
    Stuff.Parent = leaderstats
    
    --Load Data
    local data
    local playerUserID = "Player_"..player.UserId --player.UserId gets the player's user id
    
    local success, errormessage = pcall(function() --pcall stops errors
        data = dataStore:GetAsync(playerUserID) --GetAsync syncs the data to what's in the dataStore
        --if you put local it makes it so you can only call the varible in the function instead of outside
    end)
    
    if success then --this is where you set the data to the current moners
        Moners.Value = data.Moners
        Stuff.Value = data.Stuff
    end
end)

game.Players.PlayerRemoving:Connect(function(player)
    local playerUserID = "PLayer_"..player.UserId
    
    local data = {
        Moners = player.leaderstats.Moners.Value;
        Stuff = player.leaderstats.Stuff.Value;
    }
    
    dataStore:SetAsync(playerUserID, data) --SetAsync gets the data, the first parameter is what you wanna save it to, the second parameter is what you wanna save
end)