
local FallOffMap = {}

--== <|=============== RUN TIME VARIABLES ===============|>
local THRESHOLD_SCALE = 100

--== <|=============== AUX FUNCTIONS ===============|>
--* Sigmoid or S shaped function that allows to offset and smooth the filter edges, effectively allowing us to give more or less area for the map and to smooth out the terrain
local function Transform(theFallOffResult, anOffset, aSmoothValue)
    local a = aSmoothValue
    local b = anOffset
    local value = theFallOffResult
    return (math.pow(value, a)/(math.pow(value, a) + math.pow(b - b * value, a)))
end

function FallOffMap.GetMask(maskValue:number, x: number, z: number, theMapSize:number, anOffset:number, aSmoothValue:number, aThreshold: number)
    --* Masks list
    local masks ={
        [1] = Transform(0.5, anOffset, aSmoothValue),
        [2] = FallOffMap.GetSquareMask,
        [3] = FallOffMap.GetRadialMask,
        [4] = FallOffMap.GetDiamondMask,
        [5] = FallOffMap.GetFourCornersMask,
    }  

    --* Mask computation
    --## Check which mask was selected, if too high or too low
    --## Simply select no mask being applied.
    if maskValue <= 1 or maskValue > #masks  then return masks[1] end
    
    local maskResult = masks[maskValue](x, z, theMapSize, aThreshold)
    maskResult = Transform(maskResult, anOffset, aSmoothValue)
    
    return maskResult
end

--* Square mask
function FallOffMap.GetSquareMask(value1: number, value2: number, theMapSize, aThreshold: number)
    
    -- Normalization of values
    local widthFallOff = math.abs(value1/theMapSize * 2 - 1)
    local lengthFallOff = math.abs(value2/theMapSize * 2 - 1)
    
    -- Get the closes to one
    local result = math.clamp(math.max(widthFallOff, lengthFallOff)/aThreshold * THRESHOLD_SCALE, 0, 1)
    return result
end

--* Radial mask
function FallOffMap.GetRadialMask(value1: number, value2: number, theMapSize, aThreshold: number)
    
    -- normalization of values
    local widthFallOff = math.abs(value1/theMapSize * 2 - 1)
    local lengthFallOff = math.abs(value2/theMapSize * 2 - 1) 
    
    -- Pytagoras bs, lol, supposedly a circle is being inscribed on top of the square map and we are solving for the diameter by finding the hypotenuse
    local result = math.clamp(math.sqrt((widthFallOff^2 + lengthFallOff^2))/aThreshold * THRESHOLD_SCALE, 0, 1) 
    return result
end

--* Diamond Mask
function FallOffMap.GetDiamondMask(value1: number, value2: number, theMapSize, aThreshold: number)
    
    -- normalization of values
    local widthFallOff = math.abs(value1/theMapSize * 2 - 1)
    local lengthFallOff = math.abs(value2/theMapSize * 2 - 1) 
    
    local result = math.clamp(math.sqrt((widthFallOff + lengthFallOff))/aThreshold * THRESHOLD_SCALE, 0, 1) -- Diamond filter
    return result
end


--* Four Corners Mask
function FallOffMap.GetFourCornersMask(value1: number, value2: number, theMapSize, aThreshold: number)

    -- normalization of values
    local widthFallOff = math.abs(value1/theMapSize * 2 - 1)
    local lengthFallOff = math.abs(value2/theMapSize * 2 - 1) 
    
    local result = math.clamp(((1 - widthFallOff  - lengthFallOff)^2)/aThreshold * THRESHOLD_SCALE, 0, 1)  -- inner diamond with corners cut or "four corners"
    return result
end




return FallOffMap