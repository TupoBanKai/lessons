class TrainCargo < Train
  def initialize(carriages = 'Freight carriage')
    super
    @type = :cargo
  end
end