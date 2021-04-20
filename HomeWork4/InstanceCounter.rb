module InstanceCounter
    def self.included(base)
      base.extend instances
      base.send :include register_instance
    end
 @@counter = 0
    def self.instances
      @@counter
    end

    private

    def register_instance
      @@counter += 1
    end
end

#include to train route and station