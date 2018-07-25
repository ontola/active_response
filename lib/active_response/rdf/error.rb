# frozen_string_literal: true

module ActiveResponse
  module RDF
    class Error
      SCHEMA = ::RDF::Vocabulary.new('http://schema.org/')
      ONTOLA = ::RDF::Vocabulary.new('https://ns.ontola.io/')

      attr_accessor :error, :requested_url, :status

      def initialize(status, requested_url, error)
        self.status = status
        self.error = error
        self.requested_url = ::RDF::URI(requested_url)
      end

      def graph
        g = ::RDF::Graph.new
        g << [requested_url, SCHEMA[:name], title]
        g << [requested_url, SCHEMA[:text], error.message]
        g << [requested_url, ::RDF[:type], type]
        g
      end

      private

      def title
        @title ||= I18n.t('status')[status] || I18n.t('status')[500]
      end

      def type
        @type ||= ONTOLA["errors/#{error.class.name.demodulize}Error"]
      end
    end
  end
end
