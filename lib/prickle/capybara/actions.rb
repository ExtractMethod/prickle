module Prickle
  module Capybara
    module Actions

      def contains_text? text
        @text = text
        find_element
      end

      def exists?
        find_element
      end

      def click
        find_element.click
      end
    end
  end
end
