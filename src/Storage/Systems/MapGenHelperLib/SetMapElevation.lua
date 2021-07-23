return function(theMap)
    for x = 1, theMap.MapSize do
        for z = 1, theMap.MapSize do
            local tile = theMap.TileMap[x][z]
            
            local tileInstance: BasePart = tile.GameObject
            local posX = tileInstance.Position.X
            local posZ = tileInstance.Position.Z
            local yOffset = tileInstance:GetAttribute("ElevationOffset")

            tileInstance.Position = Vector3.new(posX, yOffset, posZ )
        end
    end
    print("Terrain Elevated")
end