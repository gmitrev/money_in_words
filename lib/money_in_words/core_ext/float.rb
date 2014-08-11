class Float
  def to_money(options={})
    MoneyInWords::Money.new(self, options).to_words
  end
end
