module Prickle
  module Capybara
    module Actions

      def click
        find_element.click
      end

      def contains_text? text
        @text = text
        find_element
      end

      def exists?
        find_element
      end

    end
  end
end
