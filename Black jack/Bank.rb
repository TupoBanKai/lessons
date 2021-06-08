# frozen_string_literal: true

# class for a currency
class Bank
  attr_reader :bet, :cash_account

  def initialize
    @cash_account = 0
    @bet = 10
  end

  def place_bet
    @cash_account += @bet
  end

  def seizure
    @cash_account -= @bet
  end
end
