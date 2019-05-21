# frozen_string_literal: true

module ActiveResponse
  module Controller
    module CrudDefaults
      module Update
        private

        def update_execute
          current_resource!.update permit_params
        end

        def update_failure
          respond_with_invalid_resource(active_response_options)
        end

        def update_failure_options
          {
            resource: current_resource!
          }
        end

        def update_success
          respond_with_updated_resource(active_response_options)
        end

        def update_success_options
          {
            location: update_success_location,
            notice: active_response_success_message,
            resource: current_resource!
          }
        end

        def update_success_location
          url_for(current_resource!)
        end
      end
    end
  end
end
