# frozen_string_literal: true

# responsible for creating cargo train
class TrainCargo < Train
  def initialize(carriages = 'Freight carriage')
    super
    @type = :cargo
  end
end
