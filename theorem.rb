class Theorem
  def initialize(first_leg, second_leg, hypotenuse)
    @first_leg = first_leg
    @second_leg = second_leg
    @hypotenuse = hypotenuse
    @values = [first_leg, second_leg, hypotenuse].uniq.sort
  end

  def isosceles
    if @values.length == 2
      print 'The triangle is isosceles'
    else equilateral
    end
  end

  def equilateral
    if @values.length == 1
      print 'The triangle is equilateral'
    else right_angle
    end
  end

  def right_angle
    if !(@hypotenuse > @first_leg && @hypotenuse > @second_leg)
      print 'You have specified the wrong hypotenuse'
    else @first_leg**2 + @second_leg**2 == @hypotenuse**2
      print 'The triangle is right-angled'
    end
  end
end
print 'Enter the sides of the triangle: '
theorem = Theorem.new(gets.to_i, gets.to_i, gets.to_i)
theorem.isosceles