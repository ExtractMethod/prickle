module Prickle
  module Actions
    module Match

      def contains_text? text
        handle_exception do
          find_element_by_identifier_and_text(@type, @identifier, text)
        end
      end

      private

      def method_missing method, *args
        if method =~ /(^.*)_contains_text\?$/
          find_element_by_identifier_and_text($1,  { :name => args.first } , args[1])
        else
          super
        end
      end


      def find_by_identifier_and_text_xpath element, identifier, text
        "//#{type_of(element)}[#{xpath_for(identifier)} and contains(text(), '#{text}')]"
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
