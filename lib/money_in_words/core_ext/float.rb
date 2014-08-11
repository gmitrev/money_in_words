class Float
  def to_money
    MoneyInWords::Money.new(self).to_words
  end
end
