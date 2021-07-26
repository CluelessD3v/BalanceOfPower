local ReplicatedStorage = game:GetService('ReplicatedStorage')
local mapGenFolder = ReplicatedStorage.Configuration.MapGenerationConfig

return{
    MapSize = mapGenFolder.MapSize.Value,
    TileSize = mapGenFolder.TileSize.Value,
    Seed = mapGenFolder.Seed.Value,
    Scale = mapGenFolder.Scale.Value,
    Amplitude = mapGenFolder.Amplitude.Value,
    Octaves = mapGenFolder.Octaves.Value,
    Persistence = mapGenFolder.Persistence.Value,
    FallOffOffset = mapGenFolder.FallOffOffset.Value,
    FallOffSmoothness = mapGenFolder.FallOffSmoothness.Value,
    FilterType = mapGenFolder.FilterType.Value,
}