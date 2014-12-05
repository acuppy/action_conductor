require 'ostruct'

module Handler
  class Base

    def initialize(controller, options={})
      @controller = controller
      @params     = controller.params
      @configs    = OpenStruct.new(options)

      yield @configs if block_given?
    end

    def handled?
      !!@handled
    end

    def exports(*export_arguments)
      Handler::Exporter.new(self, export_arguments).export
    end

    protected

    attr_reader :controller, :params

    def self.export(id, value=nil, &block)
      @exports ||= {}
      @exports[id] = value || block
    end

    def self.exports
      @exports ||= {}
    end
  end
end
