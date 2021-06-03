require_relative 'Card'
require_relative 'Deck'
require_relative 'Counter'
require_relative 'Player'
require_relative 'Diler'
require_relative 'Bank'

class Simulation
  @@bank = Bank.new
  def initialize
    @deck = Deck.new
    @deck.card_writer
    @user_cards = [@deck.deck.pop, @deck.deck.pop]
    @diler_cards = [@deck.deck.pop, @deck.deck.pop]
    @player = Player.new(@user_cards, @deck.deck.pop)
    @diler = Diler.new(@diler_cards, @deck.deck.pop)
    @counter = Counter.new
  end

  def start
    puts 'Your cards:'
    @user_cards.each { |card| puts "#{card.name} - #{card.suit}" }
    puts 'Your value:'
    puts @player.count_value
    puts "Your bet: #{@@bank.bet}"
    mid
  end

  def mid
    puts '1: Skip turn'
    puts '2: Take a card'
    answer = gets.chomp.to_i
    case answer
    when 1
      mid_diler
    when 2
      puts 'Your new card and value'
      @player.add_card
      puts "#{@player.third_card.name} - #{@player.third_card.suit}"
      puts @player.count_value
      mid_diler
    end
  end

  def mid_diler
    if @diler.count_value < 17
      puts 'Diler take a card'
      @diler.add_card
    end
    end_game
  end

  def end_game
    puts "Diler value - #{@diler.count_value}"
    total = @counter.who_win(@player.value, @diler.value)
    if total
      @@bank.place_bet
      puts 'Player win'
    elsif total != 'Drow'
      @@bank.seizure
      puts 'Diler win'
    end
    puts "Your balance: #{@@bank.cash_account}"
    one_more
  end

    def one_more
      puts 'One more?'
      puts '1: Yes'
      puts '2: No'
      answer = gets.to_i
      case answer
      when 1
        initialize
        start
      when 2
        true
      end
    end
end

lol = Simulation.new
lol.start
