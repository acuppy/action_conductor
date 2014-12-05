module Handler
  class Exporter

    def initialize(handler, arguments)
      @handler   = handler
      @arguments = arguments
      @exports   = handler.class.exports
    end

    def export
      output.length == 1 ? output.first : output
    end

    private

    attr_accessor :handler, :arguments, :exports

    def selected_exports
      exports.select do |key, value|
        requested_export_keys.include? key
      end
    end

    def requested_export_keys
      key_value(arguments).first
    end

    def key_value(args)
      return [exports.keys, nil]  if empty? args
      return [[args[0]], args[1]] if setter? args
      return [args, nil]
    end

    def empty?(args)
      args.empty?
    end

    def setter?(args)
      args[0].is_a? Symbol and !args[1].is_a? Symbol
    end

    def output
      @output ||= selected_exports.to_a.reduce([]) do |exports, export|
        key, value = export
        value = value.call if value.is_a? Proc
        exports << value
      end
    end
  end
end
