return function(value, min, max)
    local result = (value- min)/(max - min)
    result = math.clamp(result, 0, 1)
    return result
end