local CollectionService = game:GetService('CollectionService')

local TileMetadata = {}

function TileMetadata.SetMetadata(aValue: number, aTileAsset: BasePart, theTerrainTypes: table)
    local ocean = theTerrainTypes.Ocean
    local littoral = theTerrainTypes.Littoral
    local beach = theTerrainTypes.Beach
    local plain = theTerrainTypes.Plain
    local forest = theTerrainTypes.Forest
    local mountain = theTerrainTypes.Mountain

    if aValue < ocean.HeightValue then 

        CollectionService:AddTag(aTileAsset, ocean.TerrainName)
        aTileAsset:SetAttribute("TerrainType", ocean.TerrainName)

    elseif  aValue < littoral.HeightValue then
        CollectionService:AddTag(aTileAsset, littoral.TerrainName)
        aTileAsset:SetAttribute("TerrainType", littoral.TerrainName)
        
    elseif  aValue < beach.HeightValue then
        CollectionService:AddTag(aTileAsset, beach.TerrainName)
        aTileAsset:SetAttribute("TerrainType", beach.TerrainName)

    elseif  aValue < plain.HeightValue then
        CollectionService:AddTag(aTileAsset, plain.TerrainName)
        aTileAsset:SetAttribute("TerrainType", plain.TerrainName)

    elseif  aValue < forest.HeightValue then
        CollectionService:AddTag(aTileAsset, forest.TerrainName)
        aTileAsset:SetAttribute("TerrainType", mountain.TerrainName)

    elseif  aValue <= mountain.HeightValue then
        CollectionService:AddTag(aTileAsset, mountain.TerrainName)
        aTileAsset:SetAttribute("TerrainType", mountain.TerrainName)
    end
end

return TileMetadata