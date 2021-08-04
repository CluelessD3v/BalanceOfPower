local CollectionService = game:GetService('CollectionService')
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local GetNormalizedValue = require(ReplicatedStorage.Utilities.GetNormalizedValue)

local Debug = {}

function Debug.BlacklistTiles(self, theBlacklistedTags: table)
    
    for x = 1, self.MapSize do
        for z = 1, self.MapSize do
            local tile = self.TileMap[x][z]
            local tileInstance: BasePart = tile.GameObject
            
            for key, entry in pairs(theBlacklistedTags) do
                if CollectionService:HasTag(tileInstance, entry.Tag) then
                    tileInstance.Color = entry.Color
                end
            end 

        end
    end
end


function Debug.WhitelistTiles(self, theWhitelistedTags: table)
    for x = 1, self.MapSize do
        for z = 1, self.MapSize do
            
            local tile = self.TileMap[x][z]
            local tileInstance: BasePart = tile.GameObject
            tileInstance.BrickColor = BrickColor.new("White")
            -- Check if it has any of the filtered tags
            for key, entry in pairs(theWhitelistedTags) do
                if CollectionService:HasTag(tileInstance, entry.Tag) then
                   tileInstance.Color = entry.Color
                end

            end 
        end
    end
end


function Debug.WhitelistAndGradient(self, attribute: string, theFilteredTags: table)
    for x = 1, self.MapSize do
        for z = 1, self.MapSize do
            
            local tile = self.TileMap[x][z]
            local tileInstance: BasePart = tile.GameObject
            
            tileInstance.BrickColor = BrickColor.new("White")
            -- Check if it has any of the filtered tags
            for key, entry in pairs(theFilteredTags) do
                if CollectionService:HasTag(tileInstance, entry.Tag) then
                   tileInstance.Color = entry.Color
                   local normalizedVal = GetNormalizedValue(tileInstance:GetAttribute(attribute), entry.Max, entry.Min)

                   local r =  math.clamp((entry.Color.R * normalizedVal)+.5, 0, 1)
                   local g =  math.clamp((entry.Color.G * normalizedVal)+.5, 0, 1)
                   local b =  math.clamp((entry.Color.B * normalizedVal)+.5, 0, 1) 
                   tileInstance.Color = Color3.new(r,g,b)
                end

            end 

        end
    end
end

return Debug