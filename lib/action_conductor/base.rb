module ActionConductor
  class Base
    def initialize(controller)
      @controller = controller
      @params     = controller.params
    end

    def export(*args)
      Exporter.new(self).export(args)
    end

    def exports
      self.class.exports
    end

    def export_keys
      exports.map(&:id)
    end

    protected

    attr_reader :controller, :params

    def self.export(id, value=nil, &block)
      callback = value.nil? ? block : Proc.new { value }
      exports << DeferredExport.new(id, &callback)
    end

    def self.exports
      @exports ||= []
    end
  end
end
