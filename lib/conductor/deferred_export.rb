module Conductor
  class DeferredExport
    attr_reader :id

    def initialize(id, &callback)
      @id, @callback = id, callback
    end

    def export(context, export_value=nil)
      context.instance_exec(export_value, &callback)
    end

    private

    attr_reader :context, :callback
  end
end
