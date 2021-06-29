local CollectionService = game:GetService('CollectionService')

local ColorMap = {}


--//TODO LOOK INTO PUTTING THIS IN A MOTHERFUCKING FOR LOOP...
function ColorMap.SetTerrainColor(aTile: BasePart, theTerrainTypesMap: table)
    if CollectionService:HasTag(aTile, "Ocean") then 
        aTile.BrickColor = theTerrainTypesMap.Ocean.BrickColor
    
    elseif CollectionService:HasTag(aTile, "Littoral") then 
        aTile.BrickColor = theTerrainTypesMap.Littoral.BrickColor

    elseif CollectionService:HasTag(aTile, "Beach") then
        aTile.BrickColor = theTerrainTypesMap.Beach.BrickColor

    elseif CollectionService:HasTag(aTile, "Plain") then
        aTile.BrickColor = theTerrainTypesMap.Plain.BrickColor
    
    elseif CollectionService:HasTag(aTile, "Forest") then
        aTile.BrickColor = theTerrainTypesMap.Forest.BrickColor
    
    elseif CollectionService:HasTag(aTile, "Mountain") then
        aTile.BrickColor = theTerrainTypesMap.Mountain.BrickColor
    end

end


return ColorMap
