local CollectionService = game:GetService('CollectionService')

local Debug = {}

function Debug.FilterTilesFromBlackList(self,theFilteredTags: table, filteredColor: BrickColor)
    filteredColor = filteredColor or BrickColor.new("White")
    for x = 1, self.MapSize do
        for z = 1, self.MapSize do
            
            local tile = self.TileMap[x][z]
            local tileInstance: BasePart = tile.GameObject
            
            for _, tag in ipairs(theFilteredTags) do
                if CollectionService:HasTag(tileInstance, tag) then
                   tileInstance.BrickColor = filteredColor
                end
            end 

        end
    end
end


function Debug.FilterTilesFromWhitelist(self, theFilteredTags: table, filteredColor: BrickColor)
    filteredColor = filteredColor or BrickColor.new("White")
    for x = 1, self.MapSize do
        for z = 1, self.MapSize do
            
            local tile = self.TileMap[x][z]
            local tileInstance: BasePart = tile.GameObject
            
            for _, tag in ipairs(theFilteredTags) do
                if not CollectionService:HasTag(tileInstance, tag) then
                   tileInstance.BrickColor = filteredColor
                end
            end 

        end
    end
end


return Debug