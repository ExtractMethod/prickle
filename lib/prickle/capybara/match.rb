module Prickle
  module Actions
    module Match

      def contains_text? text
        @text = text
        find_element
      end

      private

      def xpath
        xpath = "//#{type}[#{identifier}"
        xpath << " and contains(text(), '#{@text}')" if @text
        xpath << "]"

      end
      def find_element
        handle_exception do
          find_element_by xpath
        end
      end
    end
  end
end
