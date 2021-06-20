local TerrainMap = {}



local ocean = BrickColor.new("Bright blue")
local littoral= BrickColor.new("Cyan")
local beach = BrickColor.new("Daisy orange")
local grassLand = BrickColor.new("Shamrock")
local forest = BrickColor.new("Forest green")
local hill = BrickColor.new("Medium stone grey")
local mountain = BrickColor.new("Dark stone grey")
    
function TerrainMap.ApplyTerrain(tile, noiseResult)
                
    if noiseResult < 0.1 then 
        tile.BrickColor = ocean
        tile.CFrame = CFrame.new(tile.Position + Vector3.new(0, -2, 0))
    elseif  noiseResult < .50 then
        tile.BrickColor = littoral
        tile.CFrame = CFrame.new(tile.Position + Vector3.new(0, -2, 0))
    elseif  noiseResult < .56 then
        tile.BrickColor = beach
    elseif  noiseResult < .76 then
        tile.BrickColor = grassLand
    elseif  noiseResult < .95 then
        tile.BrickColor = forest
    elseif  noiseResult < .9999999 then
        tile.BrickColor = hill
        tile.CFrame = CFrame.new(tile.Position + Vector3.new(0, 3, 0))
    elseif  noiseResult <= 1 then
        tile.BrickColor = mountain
        tile.CFrame = CFrame.new(tile.Position + Vector3.new(0, 6, 0))
    end
end

return TerrainMap