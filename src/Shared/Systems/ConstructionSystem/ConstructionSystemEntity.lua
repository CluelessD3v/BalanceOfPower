--[[
    This system would take charge of the processing of everything related to buildings before they are actually an
    object in workspace, as well as managing user interaction with it (binds, inout, etc)

]]--

local CollectionService = game:GetService('CollectionService')
local RunService = game:GetService('RunService')

local BuldingSystem = {
    Connection = nil
}

--//TODO change the prefab parameter to be a table of info
function BuldingSystem:PreviewBuilding(aPrefab: BasePart, aMouse: Mouse, anEntityWhiteList: table)
    self.Connection = RunService.Heartbeat:Connect(function()
        
        if aMouse.Target == nil  then return end

        for _, tag in ipairs(anEntityWhiteList) do
            if not CollectionService:HasTag(aMouse.Target, tag) then
                return
            end
        end
        print(aMouse.Target)
        
        local yOffset =  aMouse.Target.Size.Y/2 + aPrefab.Size.Y/2
        aPrefab.Position = aMouse.Target.Position + Vector3.new(0, yOffset, 0)
    end)
end


return BuldingSystem