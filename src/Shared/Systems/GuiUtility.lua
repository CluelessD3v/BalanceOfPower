local UIS = game:GetService('UserInputService')

local GuiUtility = {}

function GuiUtility.OnGuiButtonSetGuiVisibility(aGuiButton: GuiButton, aGuiAsset: GuiObject)
    aGuiButton.MouseButton1Click:Connect(function()
        aGuiAsset.Visible = not aGuiAsset.Visible
    end)
end

function GuiUtility.OnKeySetGuiVisibility(key: Enum.KeyCode, aGuiAsset: GuiObject)
    UIS.InputBegan:Connect(function(anInputObject, isTyping)
        if anInputObject.KeyCode == key and not isTyping then
            aGuiAsset.Visible = not aGuiAsset.Visible
        end
    end)
end

return GuiUtility