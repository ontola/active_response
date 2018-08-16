# frozen_string_literal: true

require 'active_response/controller/crud_defaults/create'
require 'active_response/controller/crud_defaults/destroy'
require 'active_response/controller/crud_defaults/edit'
require 'active_response/controller/crud_defaults/index'
require 'active_response/controller/crud_defaults/new'
require 'active_response/controller/crud_defaults/show'
require 'active_response/controller/crud_defaults/update'

require 'active_response/controller/rdf/crud_defaults'

module ActiveResponse
  module Controller
    module CrudDefaults
      include Create
      include Destroy
      include Edit
      include Index
      include New
      include Show
      include Update

      include RDF::CrudDefaults

      def default_form_options(action)
        {
          locals: form_view_locals_for(action),
          resource: current_resource,
          view: form_view_for(action)
        }
      end

      def form_view_for(action)
        return send("#{action}_view") if respond_to?("#{action}_view", true)
        default_form_view(action)
      end

      def default_form_view(action)
        action
      end

      def form_view_locals_for(action)
        return send("#{action}_view_locals") if respond_to?("#{action}_view_locals", true)
        default_form_view_locals(action)
      end

      def default_form_view_locals(_action)
        {}
      end

      def active_response_success_message
        return send("#{action_name}_success_message") if respond_to?("#{action_name}_success_message", true)
        I18n.t(success_message_translation_key, success_message_translation_opts)
      end

      def success_message_translation_key
        "active_response.actions.#{action_name}.success"
      end

      def success_message_translation_opts
        {type: current_resource.class.to_s.humanize}
      end
    end
  end
end
