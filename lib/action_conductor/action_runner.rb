module ActionConductor
  class ActionRunner

    def initialize(options={})
      @controller = options.fetch(:controller)
      @conductors = options.fetch(:conductors)
    end

    def export(*options)
      @exported ||= {}
      @exported[options] ||= begin
        exported = export_with_options(options)
        exported.length == 1 ? exported.first : exported
      end
    end

    private

    attr_accessor :controller, :conductors

    def export_with_options(options)
      initialized_conductors.flat_map { |c| c.export(*options) }
    end

    def initialized_conductors
      @initialized_conductors ||= Collection.new(conductors.map { |c| c.new(controller) })
    end
  end
end
