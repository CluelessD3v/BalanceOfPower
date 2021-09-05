local PrivateMethods = {}

function PrivateMethods.GenerateRadialFallOff(x:number, z:number, self)
    -- normalization of values
    local widthFallOff = math.abs(x/self.MapSize * 2 - 1)
    local lengthFallOff = math.abs(z/self.MapSize* 2 - 1) 
    
    -- Pytagoras bs, lol, supposedly a circle is being inscribed on top of the square map and we are solving for the diameter by finding the hypotenuse
    local result = math.clamp(math.sqrt(widthFallOff^2  + lengthFallOff^2), 0, 1)

    local a = self.FallOffOffset
    local b = self.FallOffSmoothness
    local value = result
    return math.pow(value, a)/(math.pow(value, a)+math.pow(b - b * value, a))
end


-- Square gradient
function PrivateMethods.GenerateSquareFallOff(x:number, z:number, self)
    
    -- Normalization of values
    local widthFallOff = math.abs(x/self.MapSize * 2 - 1)
    local lengthFallOff = math.abs(z/self.MapSize* 2 - 1) 
    
    -- Get the closes to one
    local result = math.clamp(math.max(widthFallOff, lengthFallOff), 0, 1)

    local a = self.FallOffOffset
    local b = self.FallOffSmoothness
    local value = result
    return math.pow(value, a)/(math.pow(value, a)+math.pow(b - b * value, a))
end





return PrivateMethods