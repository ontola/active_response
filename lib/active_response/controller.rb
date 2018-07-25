# frozen_string_literal: true

require 'active_response/controller/core'
require 'active_response/controller/crud_defaults'
require 'active_response/controller/default_responses'
require 'active_response/controller/resource_helper'

require 'active_response/controller/rdf/crud_defaults'

module ActiveResponse
  module Controller
    extend ActiveSupport::Concern

    included do
      include Controller::Core
      include Controller::CrudDefaults
      include Controller::DefaultResponses
      include Controller::ResourceHelper

      include Controller::RDF::CrudDefaults
    end
  end
end
