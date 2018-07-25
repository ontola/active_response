# frozen_string_literal: true

require 'active_response/rdf/error'
require 'active_response/responders/html'

module ActiveResponse
  module Responders
    class RDF < HTML
      def collection(opts)
        opts[:resource] = opts.delete(:collection)
        controller.respond_with_resource opts
      end

      def destroyed(opts)
        if opts[:meta].present?
          controller.render(format => [], meta: opts[:meta])
        else
          controller.head :no_content
        end
      end

      def form(**_opts)
        raise NotImplementedError, 'Forms are not available in RDF'
      end

      def invalid_resource(**opts)
        controller.render(
          format => error_graph(StandardError.new(opts[:resource].errors.full_messages.join("\n")), 422),
          status: :unprocessable_entity
        )
      end

      def new_resource(**opts)
        opts[:status] = :created
        controller.respond_with_resource(opts)
      end

      def resource(**opts)
        opts[format] = opts.delete(:resource)
        controller.render opts
      end

      def updated_resource(**opts)
        controller.respond_with_resource(opts)
      end

      private

      def error_graph(error, status)
        ActiveResponse::RDF::Error
          .new(status, controller.request.original_url, error.is_a?(StandardError) ? error : error.new)
          .graph
      end
    end
  end
end
