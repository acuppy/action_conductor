module Conductor
  class Definition
    attr_reader :handle, :class_name

    def initialize(configs={})
      @handle     = configs.fetch(:handle)
      @actions    = configs.fetch(:actions, [])
      @class_name = configs.fetch(:class_name, @handle)
    end

    def klass
      @conductor_klass ||= conductor_klass
    end

    def actions
      @actions ||= Set.new(@actions)
    end

    private

    def conductor_klass
      Object.const_get(conductor_klass_name)
    rescue NameError
      raise UndefinedConductor.new(conductor_klass_name)
    end

    def conductor_klass_name
      "#{class_name.to_s.camelize}Conductor"
    end
  end
end
