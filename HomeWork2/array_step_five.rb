value =* (10..100)
step_five = []
value.each do |i|
  if i % 5 == 0 
    step_five.push(value[i - 10])
  end
end
print step_five