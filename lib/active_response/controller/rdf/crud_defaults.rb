# frozen_string_literal: true

require 'active_response/controller/rdf/collections'

module ActiveResponse
  module Controller
    module RDF
      module CrudDefaults
        include Collections

        def create_success_options_rdf
          opts = create_success_options
          opts[:meta] = create_meta
          opts
        end

        def create_meta
          []
        end

        def destroy_success_options_rdf
          opts = destroy_success_options
          opts[:meta] = destroy_meta
          opts
        end

        def destroy_meta
          []
        end

        def index_success_options_rdf
          return index_success_options if index_collection_or_view.nil?
          {
            collection: index_collection_or_view,
            include: index_includes_collection,
            locals: index_locals,
            meta: index_meta
          }
        end

        def show_success_options_rdf
          opts = show_success_options.except(:locals)
          opts[:meta] = show_meta
          opts
        end

        def show_meta
          []
        end

        def update_success_options_rdf
          opts = update_success_options
          opts[:meta] = update_meta
          opts
        end

        def update_meta
          []
        end
      end
    end
  end
end
