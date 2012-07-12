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
          if block_given?
            block.call
            @message = popup.text
          end
          popup.accept
          self
        end

        alias :accept :confirm

        def dismiss &block
          if block_given?
            block.call
            @message = popup.text
            sleep 1
            popup.accept
            return self
          end
          popup.dismiss
        end

        def message
          @popup.text
        end

        def contains_message? message
          raise Exceptions::MessageNotContainedInPopup.new(self.message) unless self.message.eql? message
        end

      end
    end
  end
end
