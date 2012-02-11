module Prickle
  module Actions
    module Match

      def contains_text? text
        handle_exception do
          find_element_by_identifier_and_text
        end
      end

      private

      def xpath_for_identifier
        "//#{type}[#{identifier}]"
      end

      def xpath_for_identifier_and_text
        "//#{type}[#{identifier} and contains(text(), '#{@text}')]"

      end
      def find_element_by_identifier
        handle_exception do
          find_element_by xpath_for_identifier
        end
      end

      def find_element_by_identifier_and_text
        handle_exception do
          find_element_by xpath_for_identifier_and_text
        end
      end

    end
  end
end
