![](http://github.com/despo/prickle/raw/master/prickle.png)

## Configuration

To install prickle execute

```ruby
gem install prickle
```

and to configure

```ruby
require 'prickle/capybara'

World do
    include Capybara::DSL
    include Prickle::Capybara   #include it after Capybara
end
```

## Usage

### Find elements by any html tag(s)

```ruby
  element(:href => "http://google.com")
  element(:name => "blue")
  element(:id => "key")
  element(:class => "key", :id => "button")
```

### Find elements by type and html tag(s)

```ruby
  element(:link,:href => "http://google.com")
  element(:input, :name => "blue")
```

### Apply a search, a click or a text matcher

```ruby

element(:name => "flower")*.exists?*
element(:name => "flower")*.click*
element(:name => "flower")*.contains_text? "Roses"*
```

## Alternative syntax

### Find

```ruby
  find_by_name "green"
  find_button_by_name "green" #find_<element_tag>_by_name "<name>"
```

## Click

```ruby
  click_by_name "blue"
  click_input_by_name "blue" #click_<element_tag>_by_name "<name>"
```

### Match text

```ruby
  div_contains_text? "text" #<element_tag>_contains_text? "text"
```
