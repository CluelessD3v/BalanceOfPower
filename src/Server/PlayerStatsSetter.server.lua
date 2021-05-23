local Players = game:GetService('Players')

local function NewValue(aName: string, aType: ObjectValue)
    local value = Instance.new(aType)
    value.Name = aName
    
    return value
end



Players.PlayerAdded:Connect(function(aPlayer)
    
    local states = NewValue("States", "Folder")
    
    local isInBuildMode = NewValue("IsInBuildMode", "BoolValue")
    isInBuildMode.Parent = states

    states.Parent = aPlayer

    
end)