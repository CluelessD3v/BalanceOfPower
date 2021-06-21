

local CollectionService = game:GetService('CollectionService')

local TerrainMap = {}

local sea = BrickColor.new("Bright blue")
local littoral= BrickColor.new("Cyan")
local beach = BrickColor.new("Daisy orange")
local grassLand = BrickColor.new("Shamrock")
local forest = BrickColor.new("Forest green")
local hill = BrickColor.new("Medium stone grey")
local mountain = BrickColor.new("Dark stone grey")

local function SetTags(aTile: Instance, aValue: number)
    if aValue < 0.1 then 
        CollectionService:AddTag(aTile, "Sea")
    elseif  aValue < .50 then
        CollectionService:AddTag(aTile, "Littoral")
    elseif  aValue < .56 then
        CollectionService:AddTag(aTile, "Beach")
    elseif  aValue < .76 then
        CollectionService:AddTag(aTile, "Plains")
    elseif  aValue < .9999 then
        CollectionService:AddTag(aTile, "Forest")
    elseif  aValue <= 1 then
        CollectionService:AddTag(aTile, "Mountain")
    end

    if CollectionService:HasTag(aTile, "Forest") or  CollectionService:HasTag(aTile, "Beach") or CollectionService:HasTag(aTile, "Plains") then
        CollectionService:AddTag(aTile, "UseableTerrain")
    end
end


local function SetTerrain(aTile: Instance)
    if CollectionService:HasTag(aTile, "Sea") then 
        aTile.BrickColor = sea
        aTile.CFrame = CFrame.new(aTile.Position + Vector3.new(0, -2, 0))
    elseif CollectionService:HasTag(aTile, "Littoral") then 
        aTile.BrickColor = littoral
        aTile.CFrame = CFrame.new(aTile.Position + Vector3.new(0, -2, 0))
    elseif CollectionService:HasTag(aTile, "Beach") then
        aTile.BrickColor = beach
    elseif CollectionService:HasTag(aTile, "Plains") then
        aTile.BrickColor = grassLand
    elseif CollectionService:HasTag(aTile, "Forest") then
        aTile.BrickColor = forest
    elseif CollectionService:HasTag(aTile, "Hill") then
        aTile.BrickColor = hill
        aTile.CFrame = CFrame.new(aTile.Position + Vector3.new(0, 3, 0))
    elseif CollectionService:HasTag(aTile, "Mountain") then
        aTile.BrickColor = mountain
        aTile.CFrame = CFrame.new(aTile.Position + Vector3.new(0, 6, 0))
    end

end


function TerrainMap.ApplyTerrain(aTile: Instance, aValue: number)
    SetTags(aTile, aValue)
    SetTerrain(aTile)     

end

return TerrainMap