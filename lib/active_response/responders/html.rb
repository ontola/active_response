# frozen_string_literal: true

require 'active_response/responders/base'

module ActiveResponse
  module Responders
    class HTML < Base
      def collection(**opts)
        controller.render opts
      end

      def destroyed(**opts)
        opts[:status] = 303
        controller.respond_with_redirect(opts)
      end

      def form(**opts)
        controller.render opts[:view], opts.except(:view)
      end

      def invalid_resource(**opts)
        if controller.action_name == 'destroy'
          controller.respond_with_redirect(location: opts[:resource])
        else
          controller.respond_with_form(controller.default_form_options(form_for_invalid(opts)))
        end
      end

      def new_resource(**opts)
        controller.respond_with_redirect(opts)
      end

      def redirect(**opts)
        controller.redirect_to opts[:location], opts.except(:location)
      end

      def resource(**opts)
        controller.render :show, opts
      end

      def updated_resource(**opts)
        controller.respond_with_redirect(opts)
      end

      private

      def form_for_invalid(opts)
        return opts[:form] if opts[:form].present?
        return 'new' if controller.action_name == 'create'
        'edit'
      end
    end
  end
end
