
local FallOffMap = {}

function FallOffMap.Generate(value1: number, value2: number, theMapSize)
    local widthFallOff = math.abs(value1/theMapSize * 2 - 1)
    local lengthFallOff = math.abs(value2/theMapSize * 2 - 1)
    local result = math.max(widthFallOff, lengthFallOff)

    return result
end

function FallOffMap.Transform(theFallOffResult, anOffset, aSmoothValue)

    local a = aSmoothValue
    local b = anOffset
    local value = theFallOffResult
    return math.pow(value, a)/(math.pow(value, a)+math.pow(b - b * value, a))
end



return FallOffMap