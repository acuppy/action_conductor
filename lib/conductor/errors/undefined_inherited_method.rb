module Conductor
  class UndefinedInheritedMethod < StandardError
    def initialize(method)
      super("#{method} should have been defined by the conductor")
    end
  end
end
