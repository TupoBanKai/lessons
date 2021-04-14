require_relative 'carriage'
class FreigtCarriage < Carriage
  def initialize
    @type = :freight
  end
end