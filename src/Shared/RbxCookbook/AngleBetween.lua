return function (vectorA, vectorB)
	return math.acos(math.clamp(vectorA.Unit:Dot(vectorB.Unit), -1, 1))
end