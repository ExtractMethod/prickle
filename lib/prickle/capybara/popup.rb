require_relative 'popup/webkit'
require_relative 'popup/selenium'

module Prickle
  module Capybara
    class Popup

      def initialize
        return @base = Popups::Webkit.new if ::Capybara.current_driver == :webkit or ::Capybara.javascript_driver == :webkit
        @base = Popups::Selenium.new
      end


      def method_missing method, *args, &block
        if @base.respond_to? method
          @base.send method, *args, &block
        else
          super
        end

      end
    end
  end
end
