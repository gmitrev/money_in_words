require "money_in_words/version"

module MoneyInWords

  def self.to_words(num)
    groups = split_number(num)
    groups.map!{ |h| numerize2(h) }
    groups = mega(groups)
    groups.reject!(&:blank?)
    groups = join2(groups)
    groups.strip
  end

  def self.padleft!(a, n, x)
    a.insert(0, *Array.new([0, n-a.length].max, x))
  end
  def self.padright!(a, n, x)
    a.fill(x, a.length...n)
  end


  def self.split_number(num)
    num.to_i.to_s.split(//).map(&:to_i).reverse.each_slice(3).to_a.map(&:reverse).reverse
  end

  def self.njoin(num, separator=' и ')
    case num.length
    when 0
      ''
    when 1
      num.first
    else
      num[0...-1].join(" ") + separator + num.last.to_s
    end
  end

  def self.numerize2(triple)
    ones     = %w(нула един два три четири пет шест седем осем девет)
    teens    = %w(десет единадесет дванадесет тринадесет четиринадесет петнадесет шестнадесет седемнадесет осемнадесет деветнадесет)

    tens     = %w(_ _ двадесет тридесет четиридесет петдесет шестдесет седемдесет осемдесет деветдесет)
    hundreds = %W(#{""} сто двеста триста четиристотин петстотин шестстоин седемстотин осемстотин деветстотин)

    hun, ten, one = padleft!(triple, 3, 0)
    num = []
    num << hundreds[hun] if hun > 0

    case ten
    when 0
      num << ones[one] if one != 0
    when 1
      num << teens[one]
    else
      num << tens[ten]
      num << ones[one] if one != 0
    end
    njoin(num)
  end
  def self.mega(nums)
    mega = %W(#{""} хиляди милионa милиарда)

    nums.each_with_index.map do |num, i|
      place = nums.length - i - 1

      # Две хиляди, не два хиляди
      num = 'две' if num == 'два' && place == 1
      if num == 'един' && place == 1
        'хиляда'
      else
        "#{num} #{mega[place]}"
      end
    end
  end

  def self.join2(arr, separator=' и ')
    case arr.length
    when 0
      ''
    when 1
      arr.first
    else
      if arr.last.include?(" и ")
        arr.join(" ")
      else
        arr[0...-1].join(" ") + separator + arr.last.to_s
      end
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
