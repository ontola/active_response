# frozen_string_literal: true

require 'active_response/responders/html'

module ActiveResponse
  module Responders
    class JS < HTML
      def redirect(**opts)
        controller.render js: "window.location = '#{opts[:location]}'"
      end
    end
  end
end
