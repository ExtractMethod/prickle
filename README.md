# Prickle

[![Build Status](https://secure.travis-ci.org/ExtractMethod/prickle.png)](http://travis-ci.org/ExtractMethod/prickle)

![](http://github.com/despo/prickle/raw/master/prickle.png)

## Configuration

To install prickle execute

```ruby
gem install prickle
```

and to configure update your *features/support/env.rb* to include the following:

```ruby
require 'prickle/capybara'    # require


World do
   include Capybara::DSL
   include Prickle::Capybara  # include  Prickle
end
```

## Waiting for elements to become visible

To enable this feature you need to set the *Prickle::Capybara.wait_time* property.

```ruby
Prickle::Capybara.wait_time = 5
```

If you only want to extend the wait time for a particular feature, then you need to reset the wait time using *Prickle::Capybara = nil*.

## Usage

### Find elements by any html tag(s)

```ruby
element(:href => "http://google.com")
element(:name => "blue")
element(:id => "key")
element(:class => "key", :id => "button")
```

You can also find elements by a value contained in the identifier

```ruby
element(:name.like => "blue") # will match <button name="blue_12345">
```

### Find elements by type and html tag(s)

```ruby
element(:link, :href => "http://google.com")    # you can also use link and paragraph (instead of a and p)
element(:input, :name => "blue")
```

### Apply a search, a click or a text matcher

```ruby

element(:name => "flower").exists?
element(:name => "flower").click
element(:name => "flower").contains_text? "Roses"
```

## Alternative syntax

### Find

```ruby
find_by_name "green"
find_button_by_name "green" #find_<element_tag>_by_name "<name>"
```

### Click

```ruby
click_by_name "blue"
click_input_by_name "blue" #click_<element_tag>_by_name "<name>"
```

### Match text

```ruby
div_contains_text? "text" #<element_tag>_contains_text? "text"
```

## Popup actions

```ruby
confirm_popup  # can be used for both confirmation boxed and alert boxes
dismiss_popup
popup_message

popup_message_contains? "<text>"
```

## Capturing screenshots

```ruby
capture_screen
capture_screen "<file>"
```
