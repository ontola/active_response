# frozen_string_literal: true

module ActiveResponse
  module Controller
    module CrudDefaults
      module Index
        private

        def index_association
          var = :"@#{controller_name}"
          return instance_variable_get(var) if instance_variable_defined?(var)
          instance_variable_set(:"@#{controller_name}", controller_class.all)
        end

        def index_success
          respond_with_collection(active_response_options)
        end

        def index_success_options
          {
            collection: index_association,
            include: index_includes,
            locals: index_locals
          }
        end

        def index_locals
          {}
        end

        def index_includes
          {}
        end
      end
    end
  end
end
