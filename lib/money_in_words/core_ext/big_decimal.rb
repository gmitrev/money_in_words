# encoding: utf-8
require 'bigdecimal'

class BigDecimal
  def to_money(options = {})
    MoneyInWords::Money.new(to_f, options).to_words
  end
end
