local GammaColorTransition = {}
local function PowColor3(color, pow)
    return Color3.new(math.pow(color.R, pow), math.pow(color.G, pow), math.pow(color.B, pow))
end


function GammaColorTransition.LerpColor(colorA, colorB, frac, gamma)
    gamma = (gamma or 2.0)
    local ca = PowColor3(colorA, gamma)
    local cb = PowColor3(colorB, gamma)
    return PowColor3(ca:Lerp(cb, frac), 1 / gamma)
end

return GammaColorTransition