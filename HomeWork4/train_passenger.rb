class TrainPassenger < Train
  def initialize(carriage_type = 'Passenger carriages')
    super
    @type = :passenger
  end
end