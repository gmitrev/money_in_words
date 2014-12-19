require "money_in_words/integer"
# require "money_in_words/float"
require "money_in_words/money"
require "money_in_words/core_ext/integer"
require "money_in_words/core_ext/float"
require "money_in_words/core_ext/big_decimal"
require "money_in_words/version"

module MoneyInWords

  def self.to_words(num)
    case num
    when Integer
      MoneyInWords::Integer.new(num).to_words
    when Float
      MoneyInWords::Float.new(num).to_words
    end
  end

end

class String
  BLANK_RE = /\A[[:space:]]*\z/

  # A string is blank if it's empty or contains whitespaces only:
  #
  # ''.blank? # => true
  # ' '.blank? # => true
  # "\t\n\r".blank? # => true
  # ' blah '.blank? # => false
  #
  # Unicode whitespace is supported:
  #
  # "\u00a0".blank? # => true
  #
  # @return [true, false]
  def blank?
    BLANK_RE === self
  end
end
