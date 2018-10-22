# frozen_string_literal: true

require 'active_response/controller'
require 'active_response/responders/base'
require 'active_response/railtie' if defined?(Rails::Railtie)

module ActiveResponse
  cattr_accessor :responders
  self.responders = {}

  def self.responder_for(format)
    responders[format] ||=
      registered_responders
        .sort_by { |d| -d.ancestors.count }
        .detect { |responder| responder.formats.include?(format) }
  end

  def self.registered_responders
    return @registered_responders if @registered_responders.present?
    Dir[Rails.root.join('app', 'responders', '*.rb')].each { |file| require_dependency file }
    @registered_responders = ActiveResponse::Responders::Base.descendants
  end
end
