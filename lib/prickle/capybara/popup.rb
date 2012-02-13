module Prickle
  module Capybara
    class Popup

      include ::Capybara::DSL

      def initialize
        @popup = page.driver.browser.switch_to.alert
      end

      def confirm
        @popup.accept
      end

      def dismiss
        @popup.dismiss
      end

      def message
        @popup.text
      end

      def contains_message? message
        raise Exceptions::MessageNotContainedInPopup.new(message) unless self.message.eql? message
      end
    end
  end
end
