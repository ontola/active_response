# frozen_string_literal: true

module ActiveResponse
  class Railtie < ::Rails::Railtie
    initializer 'active_response.insert_middleware' do |_app|
      ActiveSupport::Reloader.to_prepare do
        ActiveResponse.responders = {}
        ActiveResponse.instance_variable_set(:@registered_responders, nil)
      end
    end
  end
end
