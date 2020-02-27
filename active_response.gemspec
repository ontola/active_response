# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

# Maintain your gem's version:
require 'active_response/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name = 'active_response'
  s.version = ActiveResponse::VERSION
  s.license = 'MIT'

  s.authors = ['Arthur Dingemans']
  s.date = File.mtime('lib/active_response/version.rb').strftime('%Y-%m-%d')
  s.email = ['arthur@argu.co']
  s.homepage = 'https://github.com/ontola/active_response'
  s.summary = 'Define Responders to handle different kind of responses in different formats'
  s.description =
    'DRY your controllers and make your API more predictable by defining responders for different formats. '\
    'E.g. Posting an invalid resource in HTML should render a form with errors, '\
    'while in JSON you expect serialized errors.'

  s.require_paths = ['lib']
  s.files = Dir.glob('lib/**/*.rb')

  s.add_runtime_dependency 'active_model_serializers', '~> 0.10'
  s.add_runtime_dependency 'railties'

  s.add_development_dependency 'rspec-rails', '= 3.7.2'
  s.add_development_dependency 'rubocop', '= 0.58.2'
end
