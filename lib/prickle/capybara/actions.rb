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

      def self.for properties
        element = Element::extract_method_missing properties
        method = ALIASES[element[:method]] || element[:method].to_sym
        [ method, element[:args] ].compact
      end
    end
  end
end
