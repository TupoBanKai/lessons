module InstanceCounter
    def self.included(base)
      base.extend ClassMethod
      base.include InstanceMethod
    end

  module ClassMethod
    attr_writer :instances

    def instances
      @instances
    end
  end

  module InstanceMethod
    protected

    def register_instance
      count = self.class.instances || 0
      count += 1
      self.class.instances = count
    end
  end
end

#include to train route and station