 return function (theFallOffResult,anOffset, aSmoothValue)

    local a = aSmoothValue
    local b = anOffset
    local value = theFallOffResult
    return math.pow(value, a)/(math.pow(value, a)+math.pow(b - b * value, a))
 end