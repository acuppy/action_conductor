module Conductor
  class DeferredExport
    attr_reader :id

    def initialize(options={})
      @id       = options.fetch(:id)
      @callback = options.fetch(:callback)
      @context  = options.fetch(:context, self)
    end

    def export(export_value=nil)
      context.instance_eval { @callback.call export_value }
    end

    private

    attr_reader :context
  end
end
