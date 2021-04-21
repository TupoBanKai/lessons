module InstanceCounter
    def self.included(base)
      base.extend ClassMethod
      base.include InstanceMethod
    end

  module ClassMethod
    attr_writer :counter

    def instances(value)
      @counter = value
    end
  end

  module InstanceMethod
    @@counter = 0

    def counter
      register_instance
    end

    protected

    def register_instance
      @@counter += 1
      self.class.instances(@@counter)
    end
  end
end

#include to train route and station