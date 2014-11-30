module Handler
  class Base
    attr_reader :controller

    def initialize(controller, options={})
      @controller = controller
      @configs    = OpenStruct.new(options)

      yield @configs if block_given?
    end

    def handle
      raise UndefinedInheritedMethod.new(__METHOD__)
    end

    def handled?
      !!@handled
    end

    def params
      controller.params
    end
  end
end
