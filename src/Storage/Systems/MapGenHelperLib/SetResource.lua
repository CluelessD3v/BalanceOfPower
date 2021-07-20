local function CalculateMaxWeight(aTable)
    local result = 0
    for _, entry in pairs(aTable) do
        result = result + entry.Weight
    end

    return result
end

return function(aTable)
    local MaxWeight = CalculateMaxWeight(aTable)
end