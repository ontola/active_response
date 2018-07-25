# frozen_string_literal: true

require 'active_response/responders/json'

module ActiveResponse
  module Responders
    class JsonApi < JSON
      def collection(**opts)
        opts[:adapter] = :json_api
        super
      end

      def invalid_resource(**opts)
        controller.render json: {errors: formatted_errors(opts[:resource].errors)}, status: :unprocessable_entity
      end

      def resource(**opts)
        opts[:adapter] = :json_api
        super
      end

      private

      def error_code(errors, key, index)
        "value_#{errors.details[key][index][:error]}".upcase
      end

      def formatted_error(errors, key)
        errors.full_messages_for(key).map.with_index { |m, i| formatted_error_hash(key, error_code(errors, key, i), m) }
      end

      def formatted_error_hash(key, code, message)
        {
          code: code,
          message: message,
          status: Rack::Utils::HTTP_STATUS_CODES[422],
          source: {parameter: key}
        }
      end

      def formatted_errors(errors)
        errors.keys.reduce([]) do |array, key|
          array.concat(formatted_error(errors, key))
        end
      end
    end
  end
end
