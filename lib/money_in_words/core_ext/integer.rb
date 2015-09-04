# encoding: utf-8
class Integer
  def to_words(options = {})
    MoneyInWords::Number.new(self, options).to_words
  end

  def to_money(options = {})
    MoneyInWords::Money.new(to_f, options).to_words
  end
end
