local CollectionService = game:GetService('CollectionService')
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local Utilities = require(ReplicatedStorage.Utilities)

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
            
            -- Check if it has any of the filtered tags
            for _, tag in ipairs(theFilteredTags) do
                if not CollectionService:HasTag(tileInstance, tag) then
                   tileInstance.BrickColor = filteredColor
                end
            end 

        end
    end
end


function Debug.filterByColorAndGradient (self, theFilteredTags: table, attribute: string, min: number, max: number)
    local filteredColor = BrickColor.new("White")


    for x = 1, self.MapSize do
        for z = 1, self.MapSize do
            
            local tile = self.TileMap[x][z]
            local tileInstance: BasePart = tile.GameObject
            
            -- Check if it has any of the filtered tags
            for _, tag in ipairs(theFilteredTags) do
                if CollectionService:HasTag(tileInstance, tag) then

                    -- Had to invert the normalization values because R1, G1, B1 == white, kinda gives me aids but oh well...
                    local normalizedVal = Utilities.GetNormalizedValue(tileInstance:GetAttribute(attribute), max, min) 
                    tileInstance.Color = Color3.new(normalizedVal, normalizedVal, normalizedVal)
                else
                    tileInstance.BrickColor = filteredColor
                end
            end 

        end
    end
end

return Debug