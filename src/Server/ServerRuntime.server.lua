local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Knit = require(ReplicatedStorage.Packages.Knit)

Knit.AddServicesDeep(ServerScriptService.Services)
Knit.Start():andThen(function()
    print("Game Started")
end):catch(warn)