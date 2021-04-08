class TrainPassenger < Train
  def initialize(carriage_type = 'Passenger carriages')
    super
    @type = 'Passenger'
  end
end