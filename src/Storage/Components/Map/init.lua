local ReplicatedStorage = game:GetService('ReplicatedStorage')
local CollectionService = game:GetService('CollectionService')

local PerlinNoise = require(script.Parent.PerlinNoise)
local FallOffMap = require(script.FallOffMap)
local TileMetadata = require(script.TileMetadata)

local Map = {} 


Map.__index = Map

function Map.new(theMapGenerationTable, theTerrainTypesTable: table, aTile: BasePart)    
    assert(aTile, "Tile argument was missing, pass a Basepart!")
    local self = setmetatable({}, Map)

    --[[ 
        note: Values are not fully random, they are selected from a range that keep the map 
        as artifact free as possible from the filters and good looking
    --]]
    theMapGenerationTable.DoRandomMapGeneration =  theMapGenerationTable.DoRandomMapGeneration or false

    if theMapGenerationTable.DoRandomMapGeneration then
        theMapGenerationTable.Seed = math.random(-64000, 64000)
        theMapGenerationTable.Amplitude = math.random(24, 28)
        theMapGenerationTable.Persistence = Random.new():NextNumber(.48, .5 )
        theMapGenerationTable.Octaves = math.random(7, 9)
        theMapGenerationTable.Scale = Random.new():NextNumber(.48, .5)
        

        theMapGenerationTable.FallOffOffset = math.random(12,15) 
        theMapGenerationTable.FallOffSmoothness = math.random(2,4)
    end
    
     -- Reads from table values and then sets the data to it’s mapped field
    if theMapGenerationTable.Seed == 0 then
        theMapGenerationTable.Seed = math.random(-100000, 100000)
    end

    local seed = math.clamp(theMapGenerationTable.Seed, -100000, 100000)
    local amplitude =  math.clamp(theMapGenerationTable.Amplitude, 1, 100)
    local scale =  math.clamp(theMapGenerationTable.Scale, .1, 1)
    local octaves =  math.clamp(theMapGenerationTable.Octaves, 1, 10)
    local persistence =  math.clamp(theMapGenerationTable.Persistence, .1,  1)

    local fallOffOffset =  math.clamp(theMapGenerationTable.FallOffOffset, 1, 10)
    local fallOffSmoothness =  math.clamp(theMapGenerationTable.FallOffSmoothness, 1, 20)
    local filterType = math.clamp(theMapGenerationTable.FilterType, 0, 2)

    local DoGenerateColorMap = theMapGenerationTable.DoGenerateColorMap or true

    -- Class properties
    self.MapSize = math.clamp(theMapGenerationTable.MapSize, 4, 512)
    self.TileSize = math.clamp(theMapGenerationTable.TileSize, 1, 100)
    self.Tiles = {}

    --print(scale, persistence, octaves)
    --Map generation    
    for i = 1, self.MapSize do
        for j = 1, self.MapSize do
            -- Noise calculation
            local noiseResult  = PerlinNoise.new({(i + seed) * scale, (j + seed) * scale}, amplitude, octaves, persistence)
            
            local fallOff = nil
            -- Check which filter if any and calculate accordingly

            if filterType == 1 then
                fallOff = FallOffMap.GenerateSquareFallOff(i, j , self.MapSize)
            elseif filterType == 2 then
                fallOff = FallOffMap.GenerateRadialFallOff(i, j , self.MapSize)
            else
                fallOff = 0
            end

            -- Finaly, transform fall off and substract it from the noise
            noiseResult  -= FallOffMap.Transform(fallOff, fallOffOffset, fallOffSmoothness)
            noiseResult  = math.clamp(noiseResult +.5  , 0, 1)

            -- Create and set metadata based in final noise result
            local tile = aTile:Clone()
            tile.Size = Vector3.new(self.TileSize, self.TileSize, self.TileSize)
            tile.Position = Vector3.new(i * tile.Size.X, tile.Size.Y, j * tile.Size.Z)
            tile.Name = i..","..j

            tile.Color = Color3.new(noiseResult , noiseResult , noiseResult ) -- Draws noise in black and white gradient (also fallback if there is no color data)
            TileMetadata.SetMetadata(noiseResult , tile, theTerrainTypesTable, DoGenerateColorMap)

            table.insert(self.Tiles, tile)
            tile.Parent = workspace 
        end
    end
    print("Map generated")
    return self
end


function Map:SetMapElevation()
    wait(1)
    for _, tile in ipairs(self.Tiles) do
        tile.Position = tile.Position + Vector3.new(0, tile:GetAttribute("ElevationOffset"), 0)

    end
    print("TerrainElevated")
end

function Map:GenerateResources()
    
end


function Map:GeneratePropsOnTile(aTile, taggedTilesList: string, taggedProps: string)
    wait(1)
    local taggedpropList = CollectionService:GetTagged(taggedProps)
    
    for i, tile in ipairs(CollectionService:GetTagged(taggedTilesList)) do
        aTile.GameObject = tile

        local prop = taggedpropList[math.random(1, #taggedpropList)]:Clone()
        prop.Name = "Grass"
        prop.Size = Vector3.new(tile.Size.X-1, .5, tile.Size.Z-1)
        
        local chance = Random.new():NextNumber(0, 1)
        if chance >= .65 then
            aTile:PlaceOnTop(prop, true)    
        end
    end
    print("Grass Generated")
end


function Map:GeneratePropsAcrossTile(aTile, taggedTilesList: string, taggedProps: string)
    wait(1)
    local taggedpropList = CollectionService:GetTagged(taggedProps)

    for _, tile in ipairs(CollectionService:GetTagged(taggedTilesList)) do
        aTile.Asset = tile

        for i = 1, tile.Size.X do
            for j = 1, tile.Size.Z do
                local chance = Random.new():NextNumber(0, 1)

                if chance >= .96 then
                    local prop = taggedpropList[math.random(1, #taggedpropList)]:Clone()
                    aTile:PlaceWithin(prop, i, j, true)
                end
            end
        end

    end

    print("Forest Generated")
end




return Map


















