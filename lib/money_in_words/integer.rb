#encoding: utf-8
#
module MoneyInWords
  class Integer

    SEPARATOR = ' и '
    ONES  = {
      male:   %w(нула един два три четири пет шест седем осем девет),
      female: %w(нула една две три четири пет шест седем осем девет),
      neuter: %w(нула едно две три четири пет шест седем осем девет)
    }
    TEENS    = %w(десет единадесет дванадесет тринадесет четиринадесет петнадесет шестнадесет седемнадесет осемнадесет деветнадесет)

    TENS     = %w(_ _ двадесет тридесет четиридесет петдесет шестдесет седемдесет осемдесет деветдесет)
    HUNDREDS = %W(#{""} сто двеста триста четиристотин петстотин шестстоин седемстотин осемстотин деветстотин)

    def initialize(num, options={})
      @num = num
      @options = options
      @article = options[:article] || :male
    end

    def to_words
      groups = split_number(@num)
      groups.map!{ |h| numerize(h) }
      groups = mega(groups)
      groups.reject!(&:blank?)
      groups = mega_join(groups)
      groups.strip
    end

    def padleft!(a, n, x)
      a.insert(0, *Array.new([0, n-a.length].max, x))
    end

    def split_number(num)
      num.to_i.to_s.split(//).map(&:to_i).reverse.each_slice(3).to_a.map(&:reverse).reverse
    end

    def numerize(triple)
      hun, ten, one = padleft!(triple, 3, 0)
      num = []
      num << HUNDREDS[hun] if hun > 0

      case ten
      when 0
        num << ONES[@article][one] if one != 0
      when 1
        num << TEENS[one]
      else
        num << TENS[ten]
        num << ONES[@article][one] if one != 0
      end
      njoin(num)
    end

    def mega(nums)
      mega = %W(#{""} хиляди милионa милиарда)

      nums.each_with_index.map do |num, i|
        place = nums.length - i - 1

        # Две хиляди, не два хиляди
        num = 'две' if num == 'два' && place == 1

        num = ONES[@article][0] if num == '' && place == 0 && nums.count == 1

        if num == ONES[@article][1] && place == 1
          'хиляда'
        else
          "#{num} #{mega[place]}"
        end
      end
    end

    def mega_join(arr, separator=SEPARATOR)
      case arr.length
      when 0
        ''
      when 1
        arr.first
      else
        if arr.last.include?(SEPARATOR)
          arr.join(" ")
        else
          arr[0...-1].join(" ") + separator + arr.last.to_s
        end
      end

    end

    def njoin(num, separator=SEPARATOR)
      case num.length
      when 0
        ''
      when 1
        num.first
      else
        num[0...-1].join(" ") + separator + num.last.to_s
      end
    end

  end
end
