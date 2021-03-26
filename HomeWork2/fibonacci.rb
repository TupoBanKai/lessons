i = -1
fibonacci = Array.new
while i
	i += 1
	if i == 0 || i == 1
		fibonacci.push(i)
	elsif i == 2
		fibonacci.push(i-1)
	elsif fibonacci.size >= 3 && fibonacci[i - 1] + fibonacci[i - 2] < 100
		fibonacci.push(fibonacci[i - 1] + fibonacci[i - 2])
	else
		break
	end
end
print fibonacci