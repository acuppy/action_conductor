module Handler
  class UndefinedInheritedMethod < StandardError
    def initialize(method)
      super("#{method} should have been defined by the handler")
    end
  end
end
