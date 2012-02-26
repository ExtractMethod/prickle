require_relative 'popup/webkit'
require_relative 'popup/selenium'

module Prickle
  module Capybara
    class Popup

      def initialize
        return @popup = Popups::Webkit.new if ::Capybara::current_driver == :webkit
        @popup = Popups::Selenium.new
      end

      def method_missing method, *args, &block
        if @popup.respond_to? method
          @popup.send method, *args, &block
        else
          super
        end
      end
    end
  end
end
