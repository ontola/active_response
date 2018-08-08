# frozen_string_literal: true

module ActiveResponse
  module Responders
    class Base
      attr_accessor :controller
      attr_accessor :format

      class_attribute :formats
      self.formats = []

      def initialize(controller, format)
        self.controller = controller
        self.format = format
      end

      def type
        self.class.type
      end

      class << self
        def respond_to(*formats)
          self.formats = formats
        end

        def type
          @type ||= name.gsub('Responder', '').underscore.to_sym
        end

        def available_formats
          descendants.map(&:formats).flatten
        end
      end
    end
  end
end
