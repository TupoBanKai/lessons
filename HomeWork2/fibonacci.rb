fibonacci = [0, 1]
  while (fibo = fibonacci.last(2).sum) < 100
    fibonacci.push(fibo)
  end
print fibonacci