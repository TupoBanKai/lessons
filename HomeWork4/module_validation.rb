# frozen_string_literal: true

# .

module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def validate(var_name, valid_type, params)
      validations << {
        var_name: var_name,
        valid_type: valid_type,
        params: params
      }
    end

    def validations
      @validations ||= []
    end
  end

  module InstanceMethods
    def validate!
      self.class.validations.each do |validation|
        var = instance_variable_get("@#{validation[:var_name]}")
        send("validate_#{validation[:valid_type]}", var, validation[:params])
      end
    end

    def validate_presence(var, params)
      params ||= nil
      raise 'Is nil' unless var.nil?
    end

    def validate_type(var, params)
      raise 'The variable does not belong to the given class' unless var.class != params
    end

    def validate_format(var, params)
      raise 'Variable does not fit regex' unless var !~ params
    end

    def valid?(*array)
      validate!(*array)
      true
    rescue StandardError
      false
    end
  end
end