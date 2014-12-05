module Handler
  class Collection
    attr_reader :handle, :handlers

    def initialize(handle=nil)
      @handle   = handle || :global
      @handlers = {}
    end

    def [](action)
      handlers[action] ||= []
    end

    def <<(action, handler)
      self[action] << handler
    end

    def exports(*args)
      handlers.each_values.map { |handler| set.exports(*args) }.flatten
    end
  end
end

{ index: [ handler_1, handler_2 ], new: [handler_3] }
