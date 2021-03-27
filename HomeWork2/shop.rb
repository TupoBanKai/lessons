class Shop
  RANGE = {
      'chocolate' => 100,
      'milk' => 200,
      'soup' => 300
    }
  def initialize
    @hash = []
    @cost = {}
  end

  def buy
    loop do
      puts '1 to show range'
      puts '2 to buy smth'
      puts '0 to exit'
      input = gets.to_i
      if input == 1
      RANGE.each { |prod_name, price| puts prod_name }
      elsif input == 2
        hasher
      elsif input == 0
        coster
        break
      end
    end
  end

  def hasher
    hash = Hash.new
    puts 'Enter the name of the product'
    product = gets.chomp
    puts 'And quantity of the product'
    quantity = gets.to_i
    basket = []
    @hash[product] = basket[product] = {RANGE[product] => quantity}
    @cost.push(RANGE[product] * quantity)
    print "Your basket: #{@hash}"
  ends

  def coster
    i = 0
    @cost.each { |value| i += value }
    puts "Your cost: #{i}"
  end

end
shop = Shop.new
shop.buy