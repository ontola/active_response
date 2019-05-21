# frozen_string_literal: true

module ActiveResponse
  module Controller
    module ResourceHelper
      private

      def current_resource
        var = :"@#{controller_name.singularize}"
        return instance_variable_get(var) if instance_variable_defined?(var)
        instance_variable_set(var, resolve_current_resource)
      end

      def current_resource!
        current_resource || raise(ActiveRecord::RecordNotFound)
      end

      def controller_class
        @controller_class ||= controller_name.classify.safe_constantize
      end

      def requested_resource
        @requested_resource ||= controller_class.find_by(id: resource_id)
      end

      # Instantiates a new record of the current controller type
      # @return [ActiveRecord::Base] A fresh model instance
      def new_resource
        controller_class.new
      end

      def resolve_current_resource
        case action_name
        when 'create', 'new'
          new_resource
        when 'index'
          nil
        else
          requested_resource
        end
      end

      def resource_id
        params[:id]
      end
    end
  end
end
