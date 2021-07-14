local CollectionService = game:GetService('CollectionService')

local TileMetadata = {}

function TileMetadata.SetMetadata(theNoiseResult: number, aTile: BasePart, theTerrainTypesTable: table)
    
    
    -- offset the index - 1 to get the current terrain and the next one
    for i = 1, #theTerrainTypesTable -1 do
        local this = theTerrainTypesTable[i] -- current value in the list
        local next = theTerrainTypesTable[i + 1]   -- next value in the list

        -- this is an If statement to check if we are in range

        if theNoiseResult >= this.TerrainThreshold and theNoiseResult <= next.TerrainThreshold then


            CollectionService:AddTag(aTile, this.TerrainTag)
            CollectionService:AddTag(aTile, this.FeatureTag)

            aTile:SetAttribute("TerrainColor", this.TerrainColor)
            aTile:SetAttribute("ElevationOffset", this.ElevationOffset)
            aTile:SetAttribute("TerrainThreshold", this.TerrainThreshold)
            

        end
    end

end
    



return TileMetadata
