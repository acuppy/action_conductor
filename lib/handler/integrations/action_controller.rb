module Handler
  module ActionController
    extend ActiveSupport::Concern

    module ClassMethods
      def handler(handle, options={})
        handlers[handle] = define_handler(handle, options)
      end

      private

      def define_handler(handle, options={})
        only_actions   = options.fetch(:only)   { self.action_methods.to_a }
        except_actions = options.fetch(:except) { [] }
        actions        = only_actions - except_actions

        Handler::Definition.new handle: handle, action: actions
      end

      def handlers
        @@handlers ||= {}
      end
    end

    def handled?
      true
    end
  end
end

if defined? ActionController::Base
  ActionController::Base.send :include, Handler::ActionController
end
