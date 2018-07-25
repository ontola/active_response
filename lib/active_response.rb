# frozen_string_literal: true

require 'active_response/controller'
require 'active_response/responders/base'

module ActiveResponse
  cattr_accessor :responders
  self.responders = {}

  def self.responder_for(format)
    responders[format] ||=
      ActiveResponse::Responders::Base
        .descendants
        .sort_by { |d| -d.ancestors.count }
        .detect { |responder| responder.formats.include?(format) }
  end
end
