num = 414.92

def num_to_words num

  currency = {
    zero: "лева",
    one: 'лев',
    many: 'лева'
  }

  levs = num.to_i
  stotinki = (num % 1).round(2)

  base = %w(нула един два три четири пет шест седем осем девет)
  teens = %w(десет единадесет дванадесет тринадесет четиринадесет петнадесет шестнадесет седемнадесет осемнадесет)
  tens = %w(десет двадесет тридесет четиридесет петдесет шестдесет седемдесет осемдесет деветдесет)
  hundreds = %w(сто двеста триста четиристотин петстотин шестстоин седемстотин осемстотин деветстотин)
  thousands = {
    one: "хиляда",
    many: 'хиляди'
  }
  millions = {
    one: "милион",
    many: 'милиона'
  }
  d = %w(хиляда, милион, милиард, билион)



  levs.to_s.split(//)
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


split_number(1_000_000.0)

def padleft!(a, n, x)
  a.insert(0, *Array.new([0, n-a.length].max, x))
end
def padright!(a, n, x)
  a.fill(x, a.length...n)
end


def split_number(num)
  num.to_i.to_s.split(//).map(&:to_i).reverse.each_slice(3).to_a.map(&:reverse).reverse
end


def numerize(triple)
  base     = %w(нула един два три четири пет шест седем осем девет)
  teens    = %w(десет единадесет дванадесет тринадесет четиринадесет петнадесет шестнадесет седемнадесет осемнадесет деветнадесет)

  tens     = %w(_ _ двадесет тридесет четиридесет петдесет шестдесет седемдесет осемдесет деветдесет)
  hundreds = %w(_ сто двеста триста четиристотин петстотин шестстоин седемстотин осемстотин деветстотин)
    base[triple.first]
  separator = ' и '

  case triple.size
  when 1
    base[triple.last]
  when 2
    case triple.first
    when 0
      base[triple.last]
    when 1
      teens[triple.last]
    else
      if triple.last == 0
        tens[triple.first]
      else
        tens[triple.first] + separator + ones(triple.last)
      end
    end
  when 3
    return hundreds[triple.first] if triple.drop(1) == [0,0]

    case triple[1]
    when *[0,1]
      hundreds[triple.first] + separator + numerize(triple.drop(1))
    else
      hundreds[triple.first] + " " + numerize(triple.drop(1))
    end
  end

end

def njoin(num, separator=' и ')
  case num.length
  when 0
    ''
  when 1
    num.first
  else
    num[0...-1].join(" ") + separator + num.last.to_s
  end
end
njoin [1,2,3]

def numerize2(triple)
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

numerize2([1,0,0])
numerize2([3,3,0])
numerize2([0,1,1])
numerize2([0,0,1])
numerize2([0,6,1])

def mega(nums)
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

def join2(arr, separator=' и ')
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

mega(["двадесет", "сто"])
mega(["триста", "двадесет", "сто"])
join2 mega(["седем", "триста", "двадесет", "сто и седем"])

def wololo(num)
  groups = split_number(num)
  groups.map!{ |h| numerize2(h) }
  groups = mega(groups)
  groups.reject!(&:blank?)
  groups = join2(groups)
end

wololo(1231)

wololo(5)
wololo(15)
wololo(20)
wololo(35)
wololo(77)
wololo(100)
wololo(101)
wololo(111)
wololo(121)
wololo(2000)


0.to_money
0.5.to_money
0.5.to_money(show_zero_leva: false)
1.to_money
1.to_money(show_zero_stotinki: true)
1.01.to_money
1.5.to_money
1.53.to_money

0.to_words
1.to_words
1.to_words(article: :neuter)
1.to_words(article: :female)
11.to_words
33.to_words
2000.to_words
2001.to_words
