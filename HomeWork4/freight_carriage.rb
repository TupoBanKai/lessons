require_relative 'carriage'
class FreigtCarriage < Carriage
  def initialize
    @carriage_type = 'Freight carriage'
  end
end