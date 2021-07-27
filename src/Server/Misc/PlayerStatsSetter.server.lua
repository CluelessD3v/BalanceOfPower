local Players = game:GetService('Players')

local function NewValue(aName: string, aType: ObjectValue)
    local value = Instance.new(aType)
    value.Name = aName
    
    return value
end



Players.PlayerAdded:Connect(function(aPlayer)
    
    local values = NewValue("Observables", "Folder") -- Folder dedicated to save Observable objects by client
    
    local InBuildMode = NewValue("InBuildMode", "BoolValue")
    InBuildMode.Parent = values

    local selectedObject = NewValue("SelectedObject", "ObjectValue")
    selectedObject.Parent = values
    
    values.Parent = aPlayer

    
end)