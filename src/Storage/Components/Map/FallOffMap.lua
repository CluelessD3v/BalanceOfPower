
local FallOffMap = {}

function FallOffMap.GenerateCircularFallOff(value1: number, value2: number, theMapSize)
    
    local widthFallOff = math.abs(value1/theMapSize * 2 - 1)
    local lengthFallOff = math.abs(value2/theMapSize * 2 - 1)    
    
   
    local result = math.clamp(math.sqrt(widthFallOff^2  + lengthFallOff^2), 0, 1)
    return result
end


function FallOffMap.GenerateSquareFallOff(value1: number, value2: number, theMapSize)
    local widthFallOff = math.abs(value1/theMapSize * 2 - 1)
    local lengthFallOff = math.abs(value2/theMapSize * 2 - 1)
    local result = math.max(widthFallOff, lengthFallOff)

    return math.clamp(result, 0, 1)
end

function FallOffMap.Transform(theFallOffResult, anOffset, aSmoothValue)

    local a = aSmoothValue
    local b = anOffset
    local value = theFallOffResult
    return math.pow(value, a)/(math.pow(value, a)+math.pow(b - b * value, a))
end



return FallOffMap