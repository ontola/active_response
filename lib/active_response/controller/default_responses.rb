# frozen_string_literal: true

module ActiveResponse
  module Controller
    module DefaultResponses
      def respond_with_collection(opts)
        active_responder.collection(opts)
      end

      def respond_with_destroyed(opts)
        active_responder.destroyed(opts)
      end

      def respond_with_form(opts)
        active_responder.form(opts)
      end

      def respond_with_invalid_resource(opts)
        active_responder.invalid_resource(opts)
      end

      def respond_with_new_resource(opts)
        active_responder.new_resource(opts)
      end

      def respond_with_redirect(opts)
        active_responder.redirect(opts)
      end

      def respond_with_resource(opts)
        active_responder.resource(opts)
      end

      def respond_with_updated_resource(opts)
        active_responder.updated_resource(opts)
      end
    end
  end
end
