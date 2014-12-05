module Handler
  module ActionController
    extend ActiveSupport::Concern

    module ClassMethods
      def handler(handle, options={})
        register_handler define_handler(handle, options)
      end

      private

      def register_handler(definition)
        definition.actions.each do |action|
          handlers[action] << definition.handler
        end
      end

      def define_handler(handle, options={})
        only_actions   = options.fetch(:only)   { self.action_methods.to_a }
        except_actions = options.fetch(:except) { [] }
        actions        = only_actions - except_actions

        Handler::Definition.new handle: handle, action: actions
      end

      def handlers(handle=nil)
        @handlers ||= {}
        @handlers[handle] ||= Handler::Collection.new(handle)
      end
    end

    def handler(handle=nil)
      @handler ||=
        controller_action = params.fetch(:action)
        handlers = self.class.send(:handlers).fetch(controller_action)
        Handler::Collection.new(handlers)
    end
  end
end

if defined? ActionController::Base
  ActionController::Base.send :include, Handler::ActionController
end
