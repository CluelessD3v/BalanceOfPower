local Players = game:GetService('Players')

local function NewValue(aName: string, aType: ObjectValue)
    local value = Instance.new(aType)
    value.Name = aName
    
    return value
end



Players.PlayerAdded:Connect(function(aPlayer)
    
    local Data = NewValue("Data", "Folder") -- Folder dedicated to save Observable objects by client
    local states = NewValue("States", "Folder")
    states.Parent = Data
    
    local InBuildMode = NewValue("InBuildMode", "BoolValue")
    InBuildMode.Parent = states

    local selectedObject: ObjectValue = NewValue("SelectedObject", "ObjectValue")
    selectedObject.Parent = Data
    
    Data.Parent = aPlayer

    
end)