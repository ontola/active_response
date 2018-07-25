# frozen_string_literal: true

require 'active_response/responders/html'

module ActiveResponse
  module Responders
    class JSON < HTML
      def collection(**opts)
        opts[:json] = opts.delete(:collection)
        controller.render opts
      end

      def destroyed(_opts)
        controller.head :no_content
      end

      def form(**_opts)
        raise NotImplementedError, 'Forms are not available in JSON'
      end

      def invalid_resource(**opts)
        opts[:json] = opts.delete(:resource).errors
        opts[:status] ||= :unprocessable_entity
        controller.render opts
      end

      def new_resource(**opts)
        opts[:status] = :created
        controller.respond_with_resource(opts)
      end

      def resource(**opts)
        opts[:json] = opts.delete(:resource)
        controller.render opts
      end

      def updated_resource(**opts)
        controller.respond_with_resource(opts)
      end
    end
  end
end
