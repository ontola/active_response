# frozen_string_literal: true

module ActiveResponse
  module Controller
    module CrudDefaults
      module New
        private

        def new_success
          respond_with_form(active_response_options)
        end

        def new_success_options
          default_form_options(:new)
        end
      end
    end
  end
end
