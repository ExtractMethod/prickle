require_relative 'capybara/element'
require_relative 'capybara/popup'
require_relative 'exceptions'
require_relative 'core_ext/symbol'

module Prickle
  module Capybara

    class << self
      attr_accessor :wait_time, :image_dir

    end

    def click_by_name name
      find_by_name(name).click
    end


    def element type=Element::OF_ANY_TYPE, identifier
      Element.new type, identifier
    end

    def find_by_name type=Element::OF_ANY_TYPE, name
      element(type, :name => name).exists?
    end

    def popup
      Popup.new
    end

    def confirm_popup
      popup.confirm
    end

    def dismiss_popup
      popup.dismiss
    end

    def popup_message
      popup.message
    end

    def popup_message_contains? message
      popup.contains_message? message
    end

    def capture_screen name=screenshot_name
      page.driver.browser.save_screenshot Capybara.image_dir + name + ".jpg"
    end

    private

    TIME_FORMATTER = "%Y%m%d-%H.%M.%s"

    def screenshot_name
      Time.now.strftime(TIME_FORMATTER)
    end

    def method_missing method, *args
      if method =~ Element::MISSING_METHOD_REGEX
        call_element_with $1, $2, $3, $4, args
      else
        super
      end
    end

    def call_element_with *properties
      type = properties[0] || properties[3]
      name = properties[4][0]
      element(type, :name => name).send *Actions::for(properties)
    end
  end
end
