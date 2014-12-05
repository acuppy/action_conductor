module Handler
  class Export
    attr_reader :id, :value, :context

    def initialize(options={})
      @id      = options.fetch(:id)
      @value   = options.fetch(:value)
      @context = options.fetch(:context)
    end

    def export
      if value.is_a? Proc
        context.instance_eval { value.call }
      else
        value
      end
    end
  end
end
