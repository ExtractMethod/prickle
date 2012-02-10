module Prickle
  module Capybara
    class ElementNotFound < Exception

      def initialize type, identifier, text, caught_exception
        element_text = "Element"
        element_text = "\e[1m#{type}\e[0m\e[31m" unless type == "*"
        text_string = " and text \e[1m#{text}\e[0m\e[31m" unless text.nil?

        raise "#{element_text} with properties \e[1m#{identifier.to_s}\e[0m\e[31m#{text_string} was not found.\n\tError: #{caught_exception.message}"
      end

    end

  end
end
