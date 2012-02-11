module Prickle
  module Actions
    module Match

      def contains_text? text
        handle_exception do
          find_element_by_identifier_and_text(@type, @identifier, text)
        end
      end

      private

      def find_by_identifier_xpath element, identifier
        "//#{type_of(element)}[#{xpath_for(identifier)}]"
      end

      def find_by_identifier_and_text_xpath element, identifier, text
        "//#{type_of(element)}[#{xpath_for(identifier)} and contains(text(), '#{text}')]"

      end
      def find_element_by_identifier element, identifier
        @type = element; @identifier = identifier
        handle_exception do
          find_element_by(find_by_identifier_xpath(element, identifier ))
        end
      end

      def find_element_by_identifier_and_text element, identifier, text
        @text = text
        handle_exception do
          find_element_by(find_by_identifier_and_text_xpath(element, identifier, text))
        end
      end

    end
  end
end
