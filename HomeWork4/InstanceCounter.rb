module InstanceCounter
  attr_accessor :counter

    def self.included(base)
      base.extend ClassMethod
      base.include InstanceMethod
    end

  module ClassMethod
    def self.instances
      self.class.counter
    end
  end

  module InstanceMethod
    protected
    @@counter = 0
    def register_instance
      @@counter += 1
    end
  end
end

#include to train route and station