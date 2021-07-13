local CollectionService = game:GetService('CollectionService')

local TileMetadata = {}

function TileMetadata.SetMetadata(theNoiseResult: number, aTile: BasePart, theTerrainTypesTable: table, DoGenerateColorMap)
    -- offset the index - 1 to get the current terrain and the next one
    for i = 1, #theTerrainTypesTable -1 do
        local this = theTerrainTypesTable[i] -- current value in the list
        local next = theTerrainTypesTable[i + 1] or this[#theTerrainTypesTable] -- next value in the list

        -- this is an If statement to check if we are in range
        if theNoiseResult >= this.TerrainThreshold and theNoiseResult <= next.TerrainThreshold then
            CollectionService:AddTag(aTile, this.ElevationTag)

            aTile:SetAttribute("ElevationOffset", this.ElevationOffset)
            aTile:SetAttribute("ElevationLevel", this.ElevationTag)

            for _, tag in ipairs(this.TerrainTags) do
                CollectionService:AddTag(aTile, tag)
                 aTile:SetAttribute("TerrainType", tag)
            end
            if DoGenerateColorMap then
                aTile.BrickColor = this.TerrainColor
            end
        end
    end
end

    



return TileMetadata
