require_relative 'capybara/element'
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

    def confirm_popup
      page.driver.browser.switch_to.alert.accept
    end

    def dismiss_popup
      page.driver.browser.switch_to.alert.dismiss
    end

    def element type=Element::OF_ANY_TYPE, identifier
      Element.new type, identifier
    end

    def find_by_name type=Element::OF_ANY_TYPE, name
      element(type, :name => name).exists?
    end

    def popup_message
      page.driver.browser.switch_to.alert.text
    end

    def popup_message_contains? message
      raise Exceptions::MessageNotContainedInPopup.new(message) unless popup_message.eql? message
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
      if method =~ /(^.*)_(contains_text\?)|(click|find)_(.*)_by_name/
        call_element_with $1, $2, $3, $4, args
      else
        super
      end
    end

    def call_element_with *properties
      node = element_with properties
      type = properties[0] || properties[3]
      name = properties[4][0]
      element(type, :name => name).send *Actions::for(node[:method], node[:args])
    end

    def element_with properties
      element = { }
      element[:method] = properties[1] || properties[2]
      element[:args] = properties[4][1]
      element
    end
  end
end
