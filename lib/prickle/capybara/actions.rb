module Prickle
  module Capybara
    module Actions

      def click
        find_element.click
      end

      def contains_text? text
        @text = text
        @identifier[:"text()".like] = text
        find_element
      end

      def has_text? text
        @text = text
        @identifier[:"text()"] = text
        find_element
      end

      def exists?
        find_element
      end

      private

      ALIASES = { "find" => :exists? }

      def self.for method, properties
        method = ALIASES[method] || method.to_sym
        [ method, properties ].compact
      end
    end
  end
end
