local CollectionService = game:GetService('CollectionService')

local TileMetadata = {}

function TileMetadata.SetMetadata(theNoiseResult: number, aTile: BasePart, theTerrainTypesMap: table, DoGenerateColorMap)
    -- offset the index - 1 to get the current terrain and the next one
    for i = 1, #theTerrainTypesMap -1 do
        local this = theTerrainTypesMap[i]
        local next = theTerrainTypesMap[i + 1]


        if theNoiseResult >= this.HeightValue and theNoiseResult <= next.HeightValue then
            for _, tag in ipairs(this.TerrainTags) do
                CollectionService:AddTag(aTile, tag)
                 aTile:SetAttribute("TerrainType", tag)
            end

            if DoGenerateColorMap then
                aTile.BrickColor = this.BrickColor
            end
        end
    end
end






return TileMetadata
