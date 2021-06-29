local CollectionService = game:GetService('CollectionService')

local TileMetadata = {}

function TileMetadata.SetMetadata(theNoiseResult: number, aTile: BasePart, theTerrainTypesMap: table)
    for i = 1, #theTerrainTypesMap - 1 do
        local this = theTerrainTypesMap[i]
        local next = theTerrainTypesMap[i + 1] or theTerrainTypesMap[#theTerrainTypesMap]
    
        if theNoiseResult >= this.HeightValue and theNoiseResult <= next.HeightValue then
            CollectionService:AddTag(aTile, this.TerrainName)
            aTile:SetAttribute("TerrainType", this.TerrainName)
            aTile.BrickColor = this.BrickColor
        end
    end
end






return TileMetadata
