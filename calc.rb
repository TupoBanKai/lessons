class Calc

	def initialize a, h
		@a = a
		@h = h
	end

	def calculate
		print 1.0/2*@a*@h
	end
end
print "Enter the base and height of the triangle: "
calc = Calc.new(gets.chomp.to_i, gets.chomp.to_i)
calc.calculate