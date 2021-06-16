# Grid Object

>Class for the grid instance in  the workspace.

Represents the **grid** instance were all tiles of the tile map are contained/stored. the grid object *can only generate square maps using the given size*.

## Constructor
`new(theGridSize: number, theSeed: number, theTileSize ): Grid`
> Creates a grid object from the given arguments

## Public Functions
`GetNumberOfTiles(): Number`
> Gets the number of tiles generated.

## Private functions
//TODO Write this part once the grid module has been refactored and modularized


## Code example
```lua
local Grid = require(pathToGridModule)

local mapSize = 128
local seed = math.random(-100, 100)
local tileSize = 20

Grid.new(mapSize, seed, tileSize) -- Note: these parameters should be set with attributes

```

