# frozen_string_literal: true

# .
module Accessor
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def attr_accessor_with_history(*attr_names)
      array = []
      attr_names.each do |attr_name|
        var_name = "@#{attr_name}".to_sym
        define_method(attr_name) { instance_variable_get(var_name) }
        define_method("#{attr_name}=".to_sym) do |value|
          instance_variable_set(var_name, value)
          self.class.mda[var_name] = array.append(value)
        end
      end
    end

    def mda
      mda = {}
    end
  end

  module InstanceMethods
    def _history(attr_name)
      @hash["@#{attr_name}"]
    end

    def strong_attr_accessor(attr_name, attr_class)
      var_name = "@#{attr_name}".to_sym
      define_method(attr_name) { instance_variable_get(var_name) }
      define_method("#{attr_name}=".to_sym) do |value|
        raise TypeError if value.class.to_s != attr_class.capitalize

        instance_variable_set(var_name, value)
      end
    end
  end
end
