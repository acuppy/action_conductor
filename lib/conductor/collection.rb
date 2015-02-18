require "delegate"

module Conductor
  class Collection < SimpleDelegator

    attr_reader :conductors

    def initialize(conductors = Array.new)
      @conductors = conductors
      super(@conductors)
    end

    def with_handle(handle)
      conductors = selected_conductors_by_handle(handle)

      if conductors.empty?
        raise "No conductors with the handle: #{handle}"
      else
        conductors
      end
    end

    private

    def selected_conductors_by_handle(handle)
      return self if handle.nil?
      self.class.new(conductors.select { |c| c.handle = handle })
    end
  end
end
