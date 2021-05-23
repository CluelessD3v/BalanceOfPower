-- Services
local RunService = game:GetService('RunService')


local BuildingSystem = {}

function BuildingSystem.ActivateBuildMode(aPlayer: Player, aMouse: Mouse)
    local isInBuildMode = aPlayer.Values.IsInBuildMode
    local selectedObjc = aPlayer.Values.SelectedObject

    if isInBuildMode.Value then
        local aBuilding = Instance.new("Part")
        aBuilding.CanCollide = false
        aBuilding.Anchored = true
        aBuilding.Parent = workspace
        aBuilding.Size = Vector3.new(10, 2, 10)
        aBuilding.BrickColor = BrickColor.new("Really red")
        
        aPlayer.Values.SelectedObject.Value = aBuilding

        aMouse.TargetFilter = aBuilding

        RunService.Heartbeat:Connect(function()
            aBuilding.Position = aMouse.Target.Position + Vector3.new(0, 1, 0)
        end)

    else
        selectedObjc.Value:Destroy()
        selectedObjc.Value = nil
    end
end


return BuildingSystem