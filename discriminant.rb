class Discriminant
  def initialize(a, b, c)
    @a = a
    @b = b
    @c = c
  end

  def calculate 
    discriminant = @b**2 - 4 * @a * @c
    if discriminant < 0
      print 'No roots'
    elsif discriminant == 0 
      one_root(discriminant)
    else
      two_root(discriminant)
    end
  end

  def one_root(discriminant)
    print (x = (@b * (-1) + Math.sqrt(discriminant))/2 * @a).round(2)
  end

  def two_root(discriminant)
    print (x = (@b * (-1) + Math.sqrt(discriminant))/2 * @a).round(2)
    print (x = (@b * (-1) - Math.sqrt(discriminant))/2 * @a).round(2)
  end
end
print 'Enter 3 numbers: '
discriminant = Discriminant.new(gets.to_i, gets.to_i, gets.to_i)
discriminant.calculate
#Не совсем понял о какой вы переменной.