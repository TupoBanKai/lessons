# frozen_string_literal: true

# responsible for creating passanger train
class TrainPassenger < Train
  def initialize(carriage_type = 'Passenger carriages')
    super
    @type = :passenger
  end
end
