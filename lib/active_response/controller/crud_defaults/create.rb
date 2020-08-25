# frozen_string_literal: true

module ActiveResponse
  module Controller
    module CrudDefaults
      module Create
        private

        def create_execute
          current_resource!.assign_attributes(permit_params)
          current_resource!.save
        end

        def create_failure
          respond_with_invalid_resource(active_response_options)
        end

        def create_failure_options
          {
            notice: active_response_failure_message,
            resource: current_resource!
          }
        end

        def create_includes
          {}
        end

        def create_success
          respond_with_new_resource(active_response_options)
        end

        def create_success_options
          {
            include: create_includes,
            location: create_success_location,
            notice: active_response_success_message,
            resource: current_resource!
          }
        end

        def create_success_location
          url_for(current_resource!)
        end
      end
    end
  end
end
