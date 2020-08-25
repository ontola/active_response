# frozen_string_literal: true

module ActiveResponse
  module Controller
    module CrudDefaults
      module Destroy
        private

        def destroy_execute
          current_resource!.destroy
        end

        def destroy_failure
          respond_with_invalid_resource(active_response_options)
        end

        def destroy_failure_options
          {
            notice: active_response_failure_message,
            resource: current_resource!
          }
        end

        def destroy_success
          respond_with_destroyed(active_response_options)
        end

        def destroy_success_options
          {
            location: destroy_success_location,
            notice: active_response_success_message,
            resource: current_resource!
          }
        end

        def destroy_success_location
          url_for("/#{controller_name}")
        end
      end
    end
  end
end
