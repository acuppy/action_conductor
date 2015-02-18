module Conductor
  class UndefinedConductor < StandardError
    def initialize(conductor_klass_name)
      super "No conductor named #{conductor_klass_name} is defined"
    end
  end
end
