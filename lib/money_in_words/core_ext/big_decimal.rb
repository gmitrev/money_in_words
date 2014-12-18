require 'bigdecimal'

class BigDecimal
  def to_money(options={})
    MoneyInWords::Money.new(self.to_f, options).to_words
  end
end
