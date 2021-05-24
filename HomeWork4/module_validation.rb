# frozen_string_literal: true

# .
module Validation
  def validate(*array)
    validate!(*array)
  end

  def validate!(*array)
    name = array.first
    array.each do |type|
      case type
      when :presence
        raise 'Is nil' unless name.nil?
      when :type
        type_class = array[-1]
        raise 'The variable does not belong to the given class' unless name.class != type_class
      when :format
        format = array[-1]
        raise 'Variable does not fit regex' unless name !~ format
      end
    end
  end

  def valid?(*array)
    validate!(*array)
    true
  rescue StandardError
    false
  end
end
