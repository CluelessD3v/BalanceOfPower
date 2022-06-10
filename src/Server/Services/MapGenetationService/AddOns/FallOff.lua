--== <|=============== SERVICES ===============|>

local FallOffMap = {}

function FallOffMap.GetMask(maskValue:number, x: number, z: number, theMapSize:number)

    local masks ={
        [1] = FallOffMap.GetSquareFallOff,
        [2] = FallOffMap.GetRadialFallOff,
        [3] = 0
    }  

    local mask = if maskValue > #masks or maskValue < #masks  then masks[3] else masks[maskValue]
        
    return mask
end

-- Radial gradient
function FallOffMap.GetRadialFallOff(value1: number, value2: number, theMapSize)
    
    -- normalization of values
    local widthFallOff = math.abs(value1/theMapSize * 2 - 1)
    local lengthFallOff = math.abs(value2/theMapSize * 2 - 1) 
    
    -- Pytagoras bs, lol, supposedly a circle is being inscribed on top of the square map and we are solving for the diameter by finding the hypotenuse
    local result = math.clamp(math.sqrt(widthFallOff^2  + lengthFallOff^2), 0, 1)

    return result
end


-- Square gradient
function FallOffMap.GetSquareFallOff(value1: number, value2: number, theMapSize)
    
    -- Normalization of values
    local widthFallOff = math.abs(value1/theMapSize * 2 - 1)
    local lengthFallOff = math.abs(value2/theMapSize * 2 - 1)
    
    -- Get the closes to one
    local result = math.clamp(math.max(widthFallOff, lengthFallOff), 0, 1)

    return result
end


-- Sigmoid or S shaped function that allows to offset and smooth the filter edges, effectively allowing us to give more or less area for the map
function FallOffMap.Transform(theFallOffResult, anOffset, aSmoothValue)
    local a = aSmoothValue
    local b = anOffset
    local value = theFallOffResult
    return math.pow(value, a)/(math.pow(value, a)+math.pow(b - b * value, a))
end



return FallOffMap