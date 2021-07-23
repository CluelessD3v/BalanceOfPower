return function(n, oldMin, oldMax, min, max)
	return (min + ((max - min) * ((n - oldMin) / (oldMax - oldMin))))
end