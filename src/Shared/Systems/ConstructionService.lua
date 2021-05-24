local RunService = game:GetService('RunService')

local ConstructionService = {}

function ConstructionService.ToggleBuildMode(aPlayer: Player)
    local isInBuildMode = aPlayer.Values.IsInBuildMode
    isInBuildMode.Value = not isInBuildMode.Value
   
    return isInBuildMode.Value
end


function ConstructionService.GetPreview(anAsset: model)
    local buildingPreview = anAsset:Clone()
    buildingPreview.Parent = workspace
    return buildingPreview
end


return ConstructionService