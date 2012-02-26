module Prickle
  module Capybara
    module Popups
      class Webkit

        include ::Capybara::DSL

        def confirm &block
          set_type_to :confirm
          manage_popup true, &block
        end

        def dismiss &block
          set_type_to :confirm
          manage_popup false, &block
        end

        def accept &block
          set_type_to :alert
          manage_popup true, &block
        end

        def message
          @message
        end

        def contains_message? message
          raise Exceptions::MessageNotContainedInPopup.new(self.message) unless self.message.include? message
        end

        private

        def set_type_to type
          @type = type
        end

        def type
          @type.to_s
        end

        def manage_popup accept=true
          listen_and accept
          yield
          restore
          capture_message
          self
        end

        def listen_and accept=true
          page.execute_script %{
          window.original_#{type}_function = window.#{type}
          window.#{type}_msg = null
          window.#{type} = function(msg) { window.#{type}_msg = msg; return #{!!accept}; }
          }
        end

        def restore
          page.execute_script "window.#{type} = window.original_#{type}_function"
        end

        def capture_message
          @message = page.evaluate_script "window.#{type}_msg"
        end

      end
    end
  end
end
