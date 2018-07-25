# frozen_string_literal: true

module ActiveResponse
  module Controller
    module CrudDefaults
      module Edit
        private

        def edit_success
          respond_with_form(active_response_options)
        end

        def edit_success_options
          default_form_options(:edit)
        end
      end
    end
  end
end
