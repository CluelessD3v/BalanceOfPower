local CollectionService = game:GetService('CollectionService')

local TileMetadata = {}

function TileMetadata.SetMetadata(theNoiseResult: number, aTile: BasePart, theTerrainTypesMap: table, DoGenerateColorMap)
    for i = 1, #theTerrainTypesMap - 1 do
        local this = theTerrainTypesMap[i]
        local next = theTerrainTypesMap[i + 1] or theTerrainTypesMap[#theTerrainTypesMap]
        --print("this is:", this, "next is:",next)
        print(i)
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
