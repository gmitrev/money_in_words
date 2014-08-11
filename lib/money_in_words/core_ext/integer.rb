class Integer
  def to_words(options={})
    MoneyInWords::Integer.new(self, options).to_words
  end

  def to_money(options={})
    MoneyInWords::Money.new(self.to_f, options).to_words
  end
end
