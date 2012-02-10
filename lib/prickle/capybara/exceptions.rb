module Prickle
  module Capybara
    class ElementNotFound < Exception

      def initialize type, identifier, text, caught_exception
        element_text = "Element"
        element_text = hightlight(type) unless type == "*"
        text_string = " and text #{highlight(text)}" unless text.nil?

        raise "#{element_text} with properties #{highlight(identifier.to_s)} #{text_string} was not found.\n\tError: #{caught_exception.message}"
      end

      def highlight text
        "\e[1m#{text}\e[0m\e[31m"
      end
    end

  end
end
