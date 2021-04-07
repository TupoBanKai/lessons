class TrainCargo < Train
  def initialize(carriages = 'Freight carriage')
    super
    @type = 'Cargo'
  end
end