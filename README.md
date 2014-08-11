# Money in Words

Turns numbers into words/money. Bulgarian only for the time being.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'money_in_words'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install money_in_words
    
## Convert numbers to words
Only works with integers:

    require "money_in_words"
    
    0.to_words
    => "нула"
    
    1.to_words
    => "един"
    
    1.to_words(article: :neuter)
    => "едно"
    
    1.to_words(article: :female)
    => "една"
    
    11.to_words
    => "единадесет"
    
    33.to_words
    => "тридесет и три"
    
    2000.to_words
    => "две хиляди"
    
    2001.to_words
    => "две хиляди и един"
    
    2001.to_words(article: :female)
    => "две хиляди и една"


## Conver numbers to money

    require "money_in_words"

    0.to_money
    => "нула лева"
    
    0.5.to_money
    => "нула лева и петдесет стотинки"
    
    0.5.to_money(show_zero_leva: false)
    => "петдесет стотинки"
    
    1.to_money
    => "един лев"
    
    1.to_money(show_zero_stotinki: true)
    => "един лев и нула стотинки"
    
    1.01.to_money
    => "един лев и една стотинка"
    
    1.5.to_money
    => "един лев и петдесет стотинки"
    
    1.53.to_money
    => "един лев и петдесет и три стотинки"

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
