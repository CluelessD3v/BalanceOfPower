--# <|=============== SERVICES ===============|>
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")

--# <|=============== DEPENDENCIES ===============|>
local Knit = require(ReplicatedStorage.Packages.Knit)

--# <|=============== RUN TIME VALUES ===============|>
local Configuration: Folder = script.Parent.Configuration


--? <|=============== KNIT LIFECYCLE (ENTRY POINT) ===============|>
local MapGenerationService = Knit.CreateService {
    Name = "MapGenerationService",
    Client = {},
}

--# Initial setup
function MapGenerationService:KnitInit()
    
    --# Biomes
    self.Terrains = {  
        [1] = {
            Name       = "Ocean",
            Threshold  = 0,
            BrickColor = BrickColor.new("Deep blue"),
            Elevation  = 0
        },

        [2] = {
            Name       = "Coast",
            Threshold  = 0.0001,
            BrickColor = BrickColor.new("Steel blue"),
            Elevation  = 0
        },

        [3] = {
            Name       = "Beach",
            Threshold  = 0.20,
            BrickColor = BrickColor.new("Daisy orange"),
            Elevation  = 0.25
        },

        [4] = {
            Name       = "Plains",
            Threshold  = 0.30,
            BrickColor = BrickColor.new("Bright green"),
            Elevation  = 0.25
        },

        
        [5] = {
            Name       = "Hills",
            Threshold  = 0.60,
            BrickColor = BrickColor.new("Dark green"),
            Elevation  = 0.50
        },

        [6] = {
            Name       = "Mountains",
            Threshold  = 0.88,
            BrickColor = BrickColor.new("Medium stone grey"),
            Elevation  = 0.75
        },

        [7] = {
            Name       = "Impassable",
            Threshold  = 0.99,
            BrickColor = BrickColor.new("Dark stone grey"),
            Elevation  = 1.25
        },

        [8] = {  --! needed placeholder due to the way appearance is set!
            Name       = "Placeholder",
            Threshold  = 1.01,
            BrickColor = BrickColor.new("Daisy orange"),
        }
    }
        --[[ source of these comments: 
        - http://libnoise.sourceforge.net/glossary/#octave
        - https://medium.com/@yvanscher/playing-with-perlin-noise-generating-realistic-archipelagos-b59f004d8401
        - https://thebookofshaders.com/13/
        - https://www.youtube.com/watch?v=wbpMiKiSKm8&list=PLFt_AvWsXl0eBW2EiBtl_sxmDtSgZBxB3

        I did my best to interpret these, to be able to define these properties. I'm utterly ignorant when it comes to math...
    -- ]]

    --# Generation Config
    
    self.GenerationParams = {
        --# Map dimensions config
        MapSize       = Configuration.MapSize,          -- Determines the area of the map
        TileSize      = Configuration.TileSize,         -- Determines the area of the tile
        TileThickness = Configuration.TileThickness,    -- Determines how thick a tile is

        --# Map generation config
        Seed         = Configuration.Seed,          -- Determines the output of the noise result
        Amplitude    = Configuration.Amplitude,     -- Determines Maximum Height of the Noise Sine
        Frequency    = Configuration.Frequency,     -- Determines frequency of... Not sure it has to do with the co sine of the wave tho (just like amp is the sine of the wave)
        Octaves      = Configuration.Octaves,       -- Determines level of detail, These are added together to Form noise more detailed noise [1, n]
        Persistance  = Configuration.Persistance,   -- Determines the amplitude of each octave the rate each octave diminshes [0.0, 1.0]
        Lacunarity   = Configuration.Lacunarity,    -- Determines Increase of frequency of octaves  [0.0, 1.0]
        Gain         = Configuration.Gain,          -- Scales the amplitude between each octave [0.0, 1.0]
        TerrainScale = Configuration.TerrainScale,  -- Determines the amplitude of the final noise result (how hilly or flat terrain is) [0.0, 1.0]c

        --# Fall off filter Config
        FallOffOffset     = Configuration.FallOffOffset,    -- Detemines how smooth is the transition of biomes from the outermost to the innermost
        FallOffSmoothness = Configuration.FallOffSmoothness -- Detemines how smooth is the transition of biomes from the outermost to the innermost
    } 
    self.TileSet = {}
end

--# Start process
function MapGenerationService:KnitStart()
    self.Seed = 0
    self:GenerateTileSet()
    
    for i = 1, 200_000 do 
        self:GenerateHeightMap()
        self.Seed = i
        task.wait()
    end
end


--- <|=============== AUX FUNCTIONS ===============|>
-- Fractal Brownian Motion noise function (full credit to Stephen Leitnick a.k.a sleitnick, src: https://github.com/Sleitnick/RDC2019-Procedural-Generation)
local function FBM(x, z, seed, amplitude, frequency, octaves, persistence, lacunarity, gain, resultScale)
	local result = 0
	for _ = 1,octaves do
		result = (result + (amplitude * math.noise(((x + seed)/frequency) * persistence, ((z + seed)/frequency) * persistence)))
		frequency = (frequency * lacunarity)
		amplitude = (amplitude * gain)
	end
	return result/resultScale
end

-- S shaped function to generate square filter that'll remove edges of the map
local function GenerateSquareFallOff(x, z, mapSize, offset, smoothness)
    -- Normalization of values
    local widthFallOff = math.abs(x/mapSize * 2 - 1)
    local lengthFallOff = math.abs(z/mapSize * 2 - 1)
    
    -- Get the closest to one
    local fallOffResult = math.clamp(math.max(widthFallOff, lengthFallOff), 0, 1)

    local a = smoothness
    local b = offset
    local value = fallOffResult
    return math.pow(value, a)/(math.pow(value, a)+math.pow(b - b * value, a))
end


--+ <|===============  PUBLIC FUNCTIONS  ===============|>
function MapGenerationService:GenerateTileSet()
    for x = 1, self.MapSize do
        for z = 1, self.MapSize do

            local Tile: Part = Instance.new("Part")
            table.insert(self.TileSet, Tile)

            Tile.Anchored   = true
            Tile.CanCollide = true
            Tile.Size       = Vector3.new(self.TileSize, self.TileThickness, self.TileSize)
            Tile.Position   = Vector3.new(x * Tile.Size.X, 20, z * Tile.Size.Z)
            Tile.Material   = Enum.Material.SmoothPlastic

            Tile:SetAttribute("XPos", x)
            Tile:SetAttribute("ZPos", z)
            
            Tile.Parent = workspace.Map
        end
    end
end


function MapGenerationService:GenerateHeightMap()
    for _, tile: BasePart in ipairs(self.TileSet) do
        
        local x: number = tile:GetAttribute("XPos")
        local z: number = tile:GetAttribute("ZPos")

        --# Generate noise value
        local noiseVal: number = FBM(x, z, self.Seed, self.Amplitude, self.Frequency, self.Octaves, self.Persistence, self.Lacunarity, self.Gain, self.TerrainScaleDivision)
        noiseVal -= GenerateSquareFallOff(x, z, self.MapSize, self.FallOffOffset, self.FallOffSmoothness)
        noiseVal = math.clamp(noiseVal, 0, 1)
        
        --# Tile biome appearance setting 
        for index, terrain in ipairs(self.Terrains) do

            local nextTerrain = self.Terrains[index + 1] 
            
            --# Since index + 1 can be nil when in the last index
            --# Break from the loop and 
            if not nextTerrain then break end

            --# Compare the noiseValue with the current and next terrain
            --# Threshold, if it's within the range apply terrain data
            if terrain.Threshold <= noiseVal and  nextTerrain.Threshold >= noiseVal   then
                tile.BrickColor = terrain.BrickColor
                tile.Position   = Vector3.new(x * tile.Size.X, 20 + terrain.Elevation, z * tile.Size.Z)
                CollectionService:AddTag(tile, terrain.Name)
                break
            end
        end
    end
end

return MapGenerationService
