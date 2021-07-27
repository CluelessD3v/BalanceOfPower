local Players = game:GetService('Players')

local function NewValue(aName: string, aType: ObjectValue)
    local value = Instance.new(aType)
    value.Name = aName
    
    return value
end



Players.PlayerAdded:Connect(function(aPlayer)
    
    local values = NewValue("Data", "Folder")
    
    local InBuildMode = NewValue("InBuildMode", "BoolValue")
    InBuildMode.Parent = values

    local selectedObject = NewValue("SelectedObject", "ObjectValue")
    selectedObject.Parent = values
    
    values.Parent = aPlayer

    
end)