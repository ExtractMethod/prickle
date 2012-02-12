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

      def exists?
        find_element
      end

    end
  end
end
