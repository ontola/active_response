# frozen_string_literal: true

module ActiveResponse
  module Controller
    module RDF
      module Collections
        ACTION_FORM_INCLUDES = [
          :resource,
          target: {
            action_body: [
              referred_shapes: :property,
              property: [referred_shapes: :property, property: [referred_shapes: :property].freeze].freeze
            ].freeze
          }.freeze
        ].freeze

        private

        def collection_includes(member_includes = {})
          {
            default_view: collection_view_includes(member_includes),
            filters: [],
            operation: ACTION_FORM_INCLUDES
          }
        end

        def collection_view_includes(member_includes = {})
          {member_sequence: {members: member_includes}}
        end

        def collection_view_params
          params.permit(:before, :page, :page_size, :type)
        end

        def index_collection
          return if index_collection_name.blank?
          @index_collection ||=
            parent_resource!.send(
              index_collection_name,
              collection_options
            )
        end

        def index_collection_name
          "#{model_name}_collection" if parent_resource.respond_to?("#{model_name}_collection")
        end

        def index_collection_or_view
          collection_view_params.present? ? index_collection&.view_with_opts(collection_view_params) : index_collection
        end

        def index_includes_collection
          collection_view_params.present? ? collection_view_includes(show_includes) : collection_includes(show_includes)
        end

        def index_meta; end
      end
    end
  end
end
