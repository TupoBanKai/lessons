months = {
	:January => 31,
	:Febrary => 28,
	:March => 31,
	:April => 30,
	:May => 31,
	:June => 30,
	:July => 31,
	:August => 31,
	:September => 30,
	:October => 31,
	:November => 30,
	:December => 31
}
months.select do |key, value|
	if value == 30
		puts "#{key}: #{value}"
	end
end




value =* (10..100)
step_five = Array.new
value.each do |i|
 	if i % 5 == 0 
 		step_five.push(value[i - 10])
 	end
end
print step_five





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





alphabet = 'a b c d e f g h i j k l m n o p q r s t u v w x y z'.split(' ')
vowls = 'a e i o u y'.split(' ')
hash = Hash.new
vowls.each do |value|
	hash[value] = alphabet.find_index(value) + 1
end
print hash