# frozen_string_literal: true

require_relative 'carriage' # inherited class

# responsible for creating the passenger carriage
class PassengerCarriage < Carriage
  def loading
    return unless @capacity - 1 >= 0

    @capacity -= 1
    @occupied_volume += 1
  end
end
