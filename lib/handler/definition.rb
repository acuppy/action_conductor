module Handler
  class Definition
    attr_reader :handle, :class_name

    def initialize(configs={})
      @handle     = configs.fetch(:handle)
      @actions    = configs.fetch(:actions, [])
      @class_name = configs.fetch(:class_name, @handle)
    end

    def handler
      @handler ||= handler_klass
    end

    def actions
      @actions ||= Set.new(@actions)
    end

    private

    def handler_klass
      Object.const_get(handler_klass_name)
    rescue NameError
      raise UndefinedHandler.new(handler_klass_name)
    end

    def handler_klass_name
      "#{class_name.camelize}Handler"
    end
  end
end
