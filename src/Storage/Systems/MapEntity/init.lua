local CollectionService = game:GetService('CollectionService')

local PerlinNoise = require(script.PerlinNoise)
local FallOffMap = require(script.FallOffMap)
local TileClass = require(script.TileEntity)
local Debug = require(script.Debug)
-------------------- Constructor --------------------
local Map = {} 
Map.__index = Map


-- Creates a new map object
function Map.new(theMapGenerationTable: table)    
    assert(theMapGenerationTable, "Map generation table no found!")

    
    local self = setmetatable({}, Map)

    --[[ 
        note: These Values are not random, they were selected so as to keep the map 
        as artifact free as possible from the filters and good looking
    --]]

    theMapGenerationTable.MapSize = theMapGenerationTable.MapSize or 100
    theMapGenerationTable.TileSize = theMapGenerationTable.TileSize or 10
    theMapGenerationTable.Seed = theMapGenerationTable.Seed or 0
    
    theMapGenerationTable.Scale = theMapGenerationTable.Scale or .5
    theMapGenerationTable.Amplitude = theMapGenerationTable.Amplitude or 25
    theMapGenerationTable.Octaves = theMapGenerationTable.Octaves or 8
    theMapGenerationTable.Persistence = theMapGenerationTable.Persistence or .5
    
    theMapGenerationTable.FallOffOffset = theMapGenerationTable.FallOffOffset or 4
    theMapGenerationTable.FallOffSmoothness = theMapGenerationTable.FallOffSmoothness or 14
    theMapGenerationTable.FilterType = theMapGenerationTable.FilterType or 0

    theMapGenerationTable.DoGenerateColorMap = theMapGenerationTable.DoGenerateColorMap or false
    theMapGenerationTable.DoRandomMapGeneration = theMapGenerationTable.DoRandomMapGeneration or false

    if theMapGenerationTable.Seed == 0 then
        theMapGenerationTable.Seed = math.random(-64000, 64000)
    end

    self.MapSize = math.clamp(theMapGenerationTable.MapSize, 1, 512)
    self.TileSize = math.clamp(theMapGenerationTable.TileSize, 1, 50)

    self.Seed = theMapGenerationTable.Seed
    self.Scale = theMapGenerationTable.Scale 
    self.Amplitude = theMapGenerationTable.Amplitude
    self.Octaves = theMapGenerationTable.Octaves
    self.Persistence = theMapGenerationTable.Persistence

    self.FallOffOffset = theMapGenerationTable.FallOffOffset
    self.FallOffSmoothness = theMapGenerationTable.FallOffSmoothness
    self.FilterType = theMapGenerationTable.FilterType


    self.TileMap = table.create(self.MapSize)
    self.TileList = table.create(self.MapSize^2)
    
    self.DoPrintStatus = false

    self.Debug = {
        FilterTiles = {
            Blacklist = Debug.BlacklistTiles,
            Whitelist = Debug.WhitelistTiles,
            WhitelistAndGradient = Debug.WhitelistAndGradient,
        }
    }

    print("Map settings set")
    return self
end

-------------------- Private Routines --------------------
local function PrintStatus(self, message)
    if self.DoPrintStatus then 
        print(message) 
    end
end
-------------------- Public Routines --------------------
-- Generates a tile map with a noise map colored on top
function Map:GenerateMap(theTerrainTypesTable: table)
    for x = 1, self.MapSize do
        self.TileMap[x] = table.create(self.MapSize) -- Reserving space in memmory beforehand

        for z = 1, self.MapSize do
            -- Noise calculation
            local noiseResult  = PerlinNoise.new({(x + self.Seed) * self.Scale, ( z + self.Seed) * self.Scale}, self.Amplitude, self.Octaves, self.Persistence)
            
            local fallOff = nil
            -- Check which filter if any and calculate accordingly

            if self.FilterType == 1 then
                fallOff = FallOffMap.GenerateSquareFallOff(x, z , self.MapSize)
            elseif self.FilterType == 2 then
                fallOff = FallOffMap.GenerateRadialFallOff(z, x , self.MapSize)
            else
                fallOff = 0
            end

            -- Finaly, transform fall off and substract it from the noise
            noiseResult  -= FallOffMap.Transform(fallOff, self.FallOffOffset, self.FallOffSmoothness)
            noiseResult  = math.clamp(noiseResult +.5  , 0, 1)

            -- Creating tile object and setting metadata via internal tile class
            local TileInstance = TileClass.new(Instance.new("Part"))
            local tileEntity :BasePart = TileInstance.GameObject
            
            tileEntity.Size = Vector3.new(self.TileSize, self.TileSize, self.TileSize)
            tileEntity.Position = Vector3.new(x * tileEntity.Size.X, tileEntity.Size.Y, z * tileEntity.Size.Z)
            tileEntity.Name = x..","..z

            tileEntity.Color = Color3.new(noiseResult , noiseResult , noiseResult ) -- Draws noise in black and white gradient (also fallback if there is no color data)
            tileEntity.Anchored = true
            tileEntity.Material = Enum.Material.SmoothPlastic
            
            TileInstance:InitMetadata(noiseResult, theTerrainTypesTable)
            
            --table.insert(newTile, self.TileList)
            self.TileMap[x][z] = tileEntity -- table.create reserved the space in table, now tiles ordered 2D-mentionally

            tileEntity.Parent = workspace 
        end
    end
    
    PrintStatus(self, "A map of size"..tostring(self.MapSize).."was generated")
end

-------------------- Transform Routines --------------------
--[[
    this routines compare the threshold value of the given data table and if the
    Threshold <= of the generated value (from randomnes or noise) it will mutate the tile metadata
]]--


-- Transform tile metadata based on a generated perlin noise value, OVERWRITES PREVIOUS DATA!
function Map:ProcedurallyTransformFromTag(aTag: string, aDataTable: table, aSeed:number)
    aSeed = aSeed or math.random(-100_000, 100_000)
    aDataTable.ExtraData.Limit = aDataTable.ExtraData.Limit or 2e9 
    aDataTable.ExtraData.FilteredTags = aDataTable.ExtraData.FilteredTags or {}
    
    local count = 0

    for x = 1, self.MapSize do
        for z = 1, self.MapSize do
            local tileInstance = TileClass.new(self.TileMap[x][z])

            -- has the given tag and have not reached the limit? then generate a noise value and check for filtered tags
            if CollectionService:HasTag(tileInstance.GameObject, aTag) and count <= aDataTable.ExtraData.Limit then
                local noiseResult:number  = PerlinNoise.new({(x + aSeed) * self.Scale, ( z + aSeed)  * self.Scale}, self.Amplitude, self.Octaves, self.Persistence)
                noiseResult  = math.clamp(noiseResult +.5  , 0, 1)
                
                local hasFilteredTag = false
                
                if noiseResult <= aDataTable.ExtraData.Threshold then
                    for _, tag in pairs(aDataTable.ExtraData.FilteredTags) do

                        if CollectionService:HasTag(tileInstance.GameObject, tag) then  
                            hasFilteredTag = true
                            break
                        end
                    end

                    if not hasFilteredTag then
                        count += 1
                        tileInstance:SetMetadata(aDataTable)
                    end
                end
            end
        end
    end

    PrintStatus(self, tostring(count).." tiles were tranformed to".. unpack(aDataTable.Tags))
end

-- Updates tile metadata based on a generated perlin noise value, Previous data IS NOT OVERWRITTEN/DELETED!( except for duplicates)
function Map:ProcedurallyUpdateFromTag(aTag: string, aDataTable: table, aTagsBlacklist: table, aSeed:number)
    aSeed = aSeed or math.random(-100_000, 100_000)
    aDataTable.ExtraData.Limit = aDataTable.ExtraData.Limit or 2e9 
    aDataTable.ExtraData.FilteredTags = aDataTable.ExtraData.FilteredTags or {}
        
    local count = 0

    for x = 1, self.MapSize do
        for z = 1, self.MapSize do
            local tileInstance = TileClass.new(self.TileMap[x][z])

            -- has the given tag and have not reached the limit? then generate a noise value and check for filtered tags
            if CollectionService:HasTag(tileInstance.GameObject, aTag) and count <= aDataTable.ExtraData.Limit then
                local noiseResult:number  = PerlinNoise.new({(x + aSeed) * self.Scale, ( z + aSeed)  * self.Scale}, self.Amplitude, self.Octaves, self.Persistence)
                noiseResult  = math.clamp(noiseResult +.5  , 0, 1)
                
                local hasFilteredTag = false
                
                if noiseResult <= aDataTable.ExtraData.Threshold then
                    for _, tag in pairs(aDataTable.ExtraData.FilteredTags) do

                        if CollectionService:HasTag(tileInstance.GameObject, tag) then  
                            hasFilteredTag = true
                            break
                        end
                    end

                    if not hasFilteredTag then
                        count += 1
                        tileInstance:UpdateMetadata(aDataTable)
                    end
                end
            end
        end
    end

    PrintStatus(self, tostring(count).." tiles were Updated to".. unpack(aDataTable.Tags))
end

-- Transforms tile metadata, the distribution is procedural, Respects previous values, dupicates are overwritten.
function Map:RandomlyTransformFromTag(aTag: string, aDataTable: table)
    aDataTable.ExtraData.FilteredTags = aDataTable.ExtraData.FilteredTags or {}
    aDataTable.ExtraData.Limit = aDataTable.ExtraData.Limit or 2e9

    local count:number = 0

    for _, tile in ipairs(CollectionService:GetTagged(aTag)) do
        local TileInstance = TileClass.new(tile)

        local chance:number = Random.new():NextNumber()
        local hasFilteredTag:boolean = false

        -- Not reached tile limit and meet the threshold? then check if there are NOT filtered tags
        if count <= aDataTable.ExtraData.Limit then
            if chance <= aDataTable.ExtraData.Threshold then
                for _, filteredTag in pairs(aDataTable.ExtraData.FilteredTags) do

                    if CollectionService:HasTag(TileInstance.GameObject, filteredTag) then  
                        hasFilteredTag = true 
                        break
                    end
                end

                if not hasFilteredTag then
                    count += 1
                    TileInstance:SetMetadata(aDataTable)
                end
            end
        end
    end

    PrintStatus(self, tostring(count).." tiles were transformed to".. unpack(aDataTable.Tags))
end

-- Updates tile metadata, the distribution is random, and threshold 0 does not updates any tile.
function Map:RandomlyUpdateFromTag(aTag: string, aDataTable: table)
    aDataTable.ExtraData.FilteredTags = aDataTable.ExtraData.FilteredTags or {}
    aDataTable.ExtraData.Limit = aDataTable.ExtraData.Limit or 2e9

    local count:number = 0

    for _, tile in ipairs(CollectionService:GetTagged(aTag)) do
        local TileInstance = TileClass.new(tile)

        local chance:number = Random.new():NextNumber()
        local hasFilteredTag:boolean = false

        -- Not reached tile limit and meet the threshold? then check if there are NOT filtered tags
        if count <= aDataTable.ExtraData.Limit then
            if chance <= aDataTable.ExtraData.Threshold then
                for _, filteredTag in pairs(aDataTable.ExtraData.FilteredTags) do

                    if CollectionService:HasTag(TileInstance.GameObject, filteredTag) then  
                        hasFilteredTag = true 
                        break
                    end
                end

                if not hasFilteredTag then
                    count += 1
                    TileInstance:UpdateMetadata(aDataTable)
                end
            end
        end
    end
    
    PrintStatus(self, tostring(count).." tiles were Updated to".. unpack(aDataTable.Tags))
    
end


-------------------- Setters --------------------

-- this function sets ONE prop on off the tile origin (respects both tile and asset sizes)
function Map:PositionInstanceOnTaggedTiles(aTag: string, aProp: Instance, aThreshold: number, hasRandomOrientation: boolean)
    if aProp == nil then 
        warn("Warning!, No game object was passed to positioning function, tile will be empty")
        return 
    end

    for _, tile in ipairs(CollectionService:GetTagged(aTag)) do
        local TileInstance = TileClass.new(tile)

        local chance = Random.new():NextNumber(0, 1)
        if chance <= aThreshold then
            TileInstance:InstanceToOriginOffseted(aProp, hasRandomOrientation)
        end
    end
end

-- THis function sets props across the tile, THIS IS TILE SIZE DEPENDANT, BIGGER TILES = MORE PROPS!
-- function Map:SetInstanceAcrossTile(aTile: BasePart, aPropList: string, aThreshold: integer, hasRandomOrientation: boolean)
--     GenerateProps.InstanceAcrossTile(aTile, aPropList, aThreshold, hasRandomOrientation)
-- end

function Map:PositionInstanceOnTaggedTileFromTable(positionTable)

end

return Map


