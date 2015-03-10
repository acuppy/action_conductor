module ActionConductor
  class Exporter

    attr_reader :conductor

    def initialize(conductor)
      @conductor = conductor
    end

    def export(arguments)
      @arguments = arguments
      output.length == 1 ? output.first : output
    end

    private

    attr_reader :arguments, :context

    def output
      @output ||= begin
        enumerable_exports do |deferred, exports|
          exports << export_deferred(deferred)
        end
      end
    end

    def enumerable_exports(&block)
      selected_exports.to_a.each_with_object([], &block)
    end

    def export_deferred(deferred)
      deferred.export(conductor, requested_export_value)
    end

    def selected_exports
      requested_export_keys.map do |key|
        exports.find { |export| export.id == key }
      end
    end

    def exports
      conductor.exports
    end

    def export_keys
      conductor.export_keys
    end

    def requested_export_keys
      key_value(arguments)[0]
    end

    def requested_export_value
      key_value(arguments)[1]
    end

    def key_value(args)
      return [export_keys, nil]   if empty? args
      return [[args[0]], args[1]] if setter? args
      return [args, nil]
    end

    def empty?(args)
      args.empty?
    end

    def setter?(args)
      args[0].is_a? Symbol and !args[1].is_a? Symbol
    end
  end
end
