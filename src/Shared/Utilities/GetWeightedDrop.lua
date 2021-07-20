-- table MUST be a dictionary and have a weight entry!

local function CalculateMaxWeight(aTable)
    local result = 0
    for _, entry in pairs(aTable) do
        result = result + entry.Weight
    end

    return result
end

return function(aWeightedTable)
    local MaxWeight = CalculateMaxWeight(aWeightedTable)
    
    local randI = math.random(MaxWeight)
    
    for _, entry in pairs(aWeightedTable) do
        if randI <= entry.Weight then
            return entry -- returns the Key so you can do whatever with the values     
        else
            randI = randI - entry.Weight   
        end
    end 
end