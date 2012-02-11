require_relative 'capybara/element'

module Prickle
  module Capybara

    class << self
      attr_accessor :wait_time, :image_dir

    end

    def capture_screen name=Time.now.strftime("%Y%m%d-%H.%M.%s")
      page.driver.browser.save_screenshot Capybara.image_dir + name + ".jpg"
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
      raise Capybara::MessageNotContainedInPopup, Error.new.not_contained_in_popup(message) unless popup_message.eql? message
    end

    private

    def method_missing method, *args
      if method =~ /(^.*)_contains_text\?$/
        element($1, :name => args.first).contains_text? args[1]
      elsif method =~ /^click_(.*)_by_name$/
        element($1, :name => args.first).click
      elsif method =~ /^find_(.*)_by_name$/
        element($1, :name => args.first).exists?
      else
        super
      end
    end

  end
end
