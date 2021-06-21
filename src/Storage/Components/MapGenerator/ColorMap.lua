local CollectionService = game:GetService('CollectionService')

local ColorMap = {}
-- Gives the given tile a terrain attribute and tag based on the given value
local sea = BrickColor.new("Bright blue")
local littoral= BrickColor.new("Cyan")
local beach = BrickColor.new("Daisy orange")
local grassLand = BrickColor.new("Shamrock")
local forest = BrickColor.new("Forest green")
local hill = BrickColor.new("Medium stone grey") 
local mountain = BrickColor.new("Dark stone grey")


function ColorMap.SetTerrainColor(aTile: Instance)
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
    
    elseif CollectionService:HasTag(aTile, "Mountain") then
        aTile.BrickColor = mountain
        aTile.CFrame = CFrame.new(aTile.Position + Vector3.new(0, 6, 0))
    end

end


return ColorMap