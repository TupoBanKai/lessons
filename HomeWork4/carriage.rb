# frozen_string_literal: true

# responsible for creating the carriage
class Carriage
  require_relative 'Module_owner'
  include Owner
  attr_reader :capacity, :occupied_volume, :type

  def initialize(capacity)
    @type = :freight
    @capacity = capacity
    @occupied_volume = 0
  end

  def loading(volume)
    return unless @capacity - volume >= 0

    @occupied_volume += volume
  end

  def show_capacity
    @capacity
  end

  def show_occupied_volume
    @occupied_volume
  end
end
