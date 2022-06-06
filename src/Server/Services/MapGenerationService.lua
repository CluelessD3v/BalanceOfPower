--# <|=============== SERVICES ===============|>
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--# <|=============== DEPENDENCIES ===============|>
local Knit = require(ReplicatedStorage.Packages.Knit)


--- <|=============== AUX FUNCTIONS ===============|>


--? <|=============== KNIT LIFECYCLE ===============|>
local MapGenerationService = Knit.CreateService {
    Name = "MapGenerationService",
    Client = {},
}

function MapGenerationService:KnitInit()

    
    
end


function MapGenerationService:KnitStart()
    for x = 1, 10 do
        for z = 1, 10 do

            local Tile: Part = Instance.new("Part")

            Tile.Anchored   = true
            Tile.CanCollide = true
            Tile.Size       = Vector3.new(1,1,1)
            Tile.Position   = Vector3.new(x * Tile.Size.X, Tile.Size.Y, z * Tile.Size.Z)
            Tile.Material   = Enum.Material.Plastic
            Tile.Parent     = workspace




        end
    end
end


return MapGenerationService
