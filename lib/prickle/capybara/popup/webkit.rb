module Prickle
  module Capybara
    module Popups
      class Webkit

      include ::Capybara::DSL

        def message
          @message
        end

        def contains_message? message
          raise Exceptions::MessageNotContainedInPopup.new(self.message) unless self.message.include? message
        end

        def accept &block
          manage_js_popup true, &block
        end

        def dismiss &block
          manage_js_popup false, &block
        end

        def accept_alert accept=true
          page.execute_script "window.original_alert_function = window.alert"
          page.execute_script "window.alert_msg = null"
          page.execute_script "window.alert = function(msg) { window.alert_msg = msg; return #{!!accept}; }"
          yield
          page.execute_script "window.alert = window.original_alert_function"
          @message =  page.evaluate_script "window.alert_msg"
          self
        end

        def message
          @message
        end

        private
        def manage_js_popup accept
          page.execute_script "window.original_confirm_function = window.confirm"
          page.execute_script "window.confirm_msg = null"
          page.execute_script "window.confirm = function(msg) { window.confirm_msg = msg; return #{!!accept}; }"
          yield
          page.execute_script "window.confirm = window.original_confirm_function"
          @message = page.evaluate_script "window.confirm_msg"
          self
        end

      end
    end
  end
end
