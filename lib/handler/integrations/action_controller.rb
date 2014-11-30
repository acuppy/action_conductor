module Handler
  module ActionController
    extend ActiveSupport::Concern

    included do
      cattr_reader :handlers
    end

    module ClassMethods
      def handler(handle, options={})
        available_actions = only_actions - except_actions

        self.handlers[handle] = define_handler(handle, options)
      end

      private

      def define_handler(handle, options={})
        only_actions   = options.fetch(:only)   { self.action_methods.to_a }
        except_actions = options.fetch(:except) { [] }

        Handler::Definition.new do |definition|
          definition.handle  = handle
          definition.actions = only_actions - except_actions
        end
      end

      def handlers
        @@handlers ||= {}
      end
    end
  end
end

if defined? ActionController::Base
  ActionController::Base.send :include, Handler::ActionController
end
