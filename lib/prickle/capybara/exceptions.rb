module Prickle
  module Capybara

    class ElementNotFound < Exception; end;

    class MessageNotContainedInPopup < Exception; end;

    class Error

      def initialize type=nil, identifier=nil, text=nil, caught_exception=nil
        @element_type = type
        @element_identifier = identifier
        @element_text = text
        @caught_exception = caught_exception
      end

      def message
        "#{element_text} with properties #{identifier} #{text_string} was not found.\n\tError: #{@caught_exception.message}"
      end

      def not_contained_in_popup message
        "Text #{highlight(message)} is not contained in the popup."
      end

      private

      def element_text
        return highlight(@element_type) unless @element_type == "*"
        "Element"
      end

      def text_string
        " and text #{highlight(@element_text)}" unless @element_text.nil?
      end

      def identifier
        highlight(@element_identifier.to_s)
      end

      def highlight text
        "\e[1m#{text}\e[0m\e[31m"
      end
    end
  end
end
