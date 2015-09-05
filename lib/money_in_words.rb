# encoding: utf-8
require 'money_in_words/number'
require 'money_in_words/money'
require 'money_in_words/core_ext/integer'
require 'money_in_words/core_ext/float'
require 'money_in_words/core_ext/big_decimal'
require 'money_in_words/version'

module MoneyInWords
  def self.to_words(num)
    case num
    when Integer
      MoneyInWords::Number.new(num).to_words
    when Float
      MoneyInWords::Float.new(num).to_words
    end
  end
end

# Shamelessly copied from ActiveSupport
class String
  BLANK_RE = /\A[[:space:]]*\z/

  def blank?
    BLANK_RE === self
  end
end

