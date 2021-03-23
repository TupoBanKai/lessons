class WeighingMachine
  def initialize(name, growth)
    @name = name
      @growth = growth
  end
  def starter
    if @growth < 110
      print 'Your weight is already optimal'
    else
      print "#{@name}, your optimal weight is #{(@growth - 110) * 1.15}"
    end
  end
end
print 'Enter name and height: '
weighing_machine = WeighingMachine.new(gets.chomp, gets.to_i)
weighing_machine.starter