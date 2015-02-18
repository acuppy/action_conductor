module Conductor
  module ActionController
    extend ActiveSupport::Concern

    module ClassMethods
      def conductor(handle, options={})
        register_conductor define_conductor(handle, options)
      end

      private

      def register_conductor(definition)
        conductors << definition.klass

        define_method "#{definition.handle}_conductor" do
          self.conductor(definition.handle)
        end
      end

      def define_conductor(handle, options={})
        only_actions   = options.fetch(:only)   { self.action_methods.to_a }
        except_actions = options.fetch(:except) { [] }
        actions        = only_actions - except_actions

        Definition.new(handle: handle, actions: actions)
      end

      def conductors
        @conductors ||= Collection.new
      end
    end

    def conductor(handle=nil)
      @action_runner ||= {}
      @action_runner[handle] ||=
        ActionRunner.new( controller: self, conductors: conductors.with_handle(handle))
    end

    def exports(*args)
      conductor.export(*args)
    end

    private

    def conductors
      _conductors = self.class.send(:conductors)

      if _conductors.empty?
        raise "No conductors have been defined"
      else
        _conductors
      end
    end
  end
end

if defined? ActionController::Base
  ActionController::Base.send :include, Conductor::ActionController
end
