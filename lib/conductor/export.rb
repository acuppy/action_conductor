module Conductor
  class Export
    attr_reader :id, :value, :context

    def initialize(options={})
      @id      = options.fetch(:id)
      @value   = options.fetch(:value)
      @context = options.fetch(:context)
    end

    def export(export_value=nil)
      if value.is_a? Proc
        context.instance_eval { value.call exported_value }
      else
        value
      end
    end
  end
end
