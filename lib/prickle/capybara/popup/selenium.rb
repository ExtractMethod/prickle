module Prickle
  module Capybara
    module Popups
      class Selenium

        include ::Capybara::DSL

        def initialize
          @popup = page.driver.browser.switch_to.alert rescue nil
        end

        alias :popup :initialize

        def confirm &block
          handle_webkit_syntax &block if block_given?
          popup.accept
          self
        end

        alias :accept :confirm

        def dismiss &block
          return handle_webkit_syntax_dismiss &block if block_given?
          popup.dismiss
        end

        def message
          @popup.text
        end

        def contains_message? message
          raise Exceptions::MessageNotContainedInPopup.new(self.message) unless self.message.eql? message
        end

        private

        def handle_webkit_syntax_dismiss &block
          handle_webkit_syntax &block
          popup.accept
          self
        end

        def handle_webkit_syntax &block
          block.call
          @message = popup.text
        end

      end
    end
  end
end
