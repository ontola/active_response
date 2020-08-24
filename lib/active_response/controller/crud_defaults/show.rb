# frozen_string_literal: true

module ActiveResponse
  module Controller
    module CrudDefaults
      module Show
        private

        def show_success
          respond_with_resource(active_response_options)
        end

        def show_success_options
          {
            include: show_includes,
            locals: show_view_locals,
            resource: current_resource!
          }
        end

        def show_includes
          {}
        end

        def show_view_locals
          {}
        end
      end
    end
  end
end
