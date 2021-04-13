require_relative 'carriage'
class FreigtCarriage < Carriage
  def initialize
    @type = 'Freight carriage'
  end
end