module Handler
  class UndefinedHandler < StandardError
    def initialize(handler_klass_name)
      super "No handler named #{handler_klass_name} is defined"
    end
  end
end
