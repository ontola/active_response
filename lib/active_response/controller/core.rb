# frozen_string_literal: true

module ActiveResponse
  module Controller
    module Core
      extend ActiveSupport::Concern

      included do
        attr_reader :active_responder
      end

      module ClassMethods
        def active_response(*actions)
          active_response(:create, :destroy, :edit, :index, :new, :show, :update) if actions.include?(:crud)
          actions.without(:crud).each { |action| define_active_response_action(action) }
        end

        private

        def define_active_response_action(action)
          define_method action do
            active_response_block do
              execute_action
            end
          end
        end
      end

      private

      def active_response_block
        respond_to do |format|
          active_response_custom_responses(format)
          ActiveResponse::Responders::Base.available_formats.each do |symbol|
            format.send(symbol) do
              find_active_responder(format)
              yield
            end
          end
        end
      end

      def active_response_custom_responses(_format); end

      def active_response_type
        @active_responder.type
      end

      def active_response_options
        base = "#{action_name}_#{@active_response_resolution}_options"
        if respond_to?("#{base}_#{active_response_type}", true)
          send("#{base}_#{active_response_type}")
        else
          send(base)
        end
      end

      def active_response_handle_failure(_resource = nil)
        respond_with_failure!
        if respond_to?("#{action_name}_failure_#{active_response_type}", true)
          return send("#{action_name}_failure_#{active_response_type}")
        end
        send("#{action_name}_failure")
      end

      def active_response_handle_success(_resource = nil)
        respond_with_success!
        if respond_to?("#{action_name}_success_#{active_response_type}", true)
          return send("#{action_name}_success_#{active_response_type}")
        end
        send("#{action_name}_success")
      end

      def active_response_success?
        @active_response_resolution == :success
      end

      def execute_action
        return active_response_handle_success unless respond_to?("#{action_name}_execute", true)
        send("#{action_name}_execute") ? active_response_handle_success : active_response_handle_failure
      end

      def find_active_responder(format)
        format_symbol = format.format.symbol
        @active_responder = ActiveResponse.responder_for(format_symbol).new(self, format_symbol)
      end

      def respond_with_failure!
        @active_response_resolution = :failure
      end

      def respond_with_success!
        @active_response_resolution = :success
      end
    end
  end
end
