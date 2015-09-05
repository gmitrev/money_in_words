# encoding: utf-8
module MoneyInWords
  class Number
    SEPARATOR = ' и '
    ONES  = {
      male:   %w(нула един два три четири пет шест седем осем девет),
      female: %w(нула една две три четири пет шест седем осем девет),
      neuter: %w(нула едно две три четири пет шест седем осем девет)
    }
    TEENS    = %w(десет единадесет дванадесет тринадесет четиринадесет петнадесет шестнадесет седемнадесет осемнадесет деветнадесет)

    TENS     = %w(_ _ двадесет тридесет четиридесет петдесет шестдесет седемдесет осемдесет деветдесет)
    HUNDREDS = %W(#{''} сто двеста триста четиристотин петстотин шестстоин седемстотин осемстотин деветстотин)

    # Available options:
    #   article: :male | :female | :neuter
    def initialize(number, options = {})
      @number = number.to_i
      @article = options[:article] || :male
    end

    # Transform the number into words
    def to_words
      postfix_compose(
        :split_to_triplets,
        :triplets_to_words,
        :add_scales,
        :remove_blanks,
        :join
      ).call(@number)
    end

    private

    def compose(*methods)
      postfix_compose(*methods.reverse)
    end

    def postfix_compose(*methods)
      lambda do |arg|
        methods.map! { |m| m.is_a?(Symbol) ? method(m) : m }

        methods.reduce(arg) { |a, f| f.call(a) }
      end
    end

    def thread_first(arg, *methods)
      postfix_compose(methods).call(arg)
    end

    # Transforms the given number into an array of triplets
    # 1       => [[1]]
    # 1413    => [[1], [413]]
    # 244_333 => [[2, 4, 4], [3, 3, 3]]
    def split_to_triplets(num)
      num.to_s.split(//).map(&:to_i).reverse.each_slice(3).to_a.map(&:reverse).reverse
    end

    # Map all triplets to words
    def triplets_to_words(triplets)
      triplets.map { |t| triplet_to_words(t) }
    end

    # Transforms a triplet into words
    # [5] => 'пет'
    # [3,4,5] => 'триста четиридесет и пет'
    def triplet_to_words(triplet)
      num = []
      hun, ten, one = padleft(triplet)

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

      join_triplet(num)
    end

    # Pads the triplet with zeroes
    # []     => [0, 0, 0]
    # [4]    => [0, 0, 4]
    # [4, 5] => [0, 4, 5]
    def padleft(triplet, count = 3, pad_with = 0)
      pad_size = [0, count - triplet.length].max

      triplet.insert(0, *Array.new(pad_size, pad_with))
    end

    # Joins the triplet elements with the separator
    # []                            => ''
    # ['еднo']                      => 'едно'
    # ['двадесет', 'две']           => 'двадесет и две'
    # ['сто', 'тридесет', 'четири'] => 'сто тридесет и четири'
    def join_triplet(triplet, separator = SEPARATOR)
      case triplet.length
      when 0
        ''
      when 1
        triplet.first
      else
        triplet[0...-1].join(' ') + separator + triplet.last.to_s
      end
    end

    # Add appropriate names to the numbers
    #  ['сто двадесет и три', 'петнадесет'] => ['сто двадесет и три хиляди', 'петнадесет']
    def add_scales(nums)
      scales = %W(#{''} хиляди милионa милиарда билиона билиарда трилиона трилиарда)

      nums.each_with_index.map do |num, index|
        place = nums.length - index - 1 # determine the index in the 'scales' array

        # Special case for two thousand
        # Две хиляди, не два хиляди
        num = 'две' if num == 'два' && place == 1

        num = ONES[@article][0] if num == '' && place == 0 && nums.count == 1

        if num == ONES[@article][1] && place == 1
          # Another special case for one thousand
          'хиляда'
        else
          "#{num} #{scales[place]}".strip
        end
      end
    end

    def remove_blanks(groups)
      groups.reject(&:blank?)
    end

    # Concat all triplets and return the final result
    # ['сто двадесет и три'] => 'сто двадесет и три'
    # ! ['хиляда', 'сто'] => 'хиляда и сто'
    # ['сто двадесет и три хиляди', 'триста тридесет и три'] => 'сто двадесет и три хиляди триста тридесет и три'
    def join(triplets, separator = SEPARATOR)
      case triplets.length
      when 0
        ''
      when 1
        triplets.first
      else
        # Special case: the separator place in the last triplet
        # 100_100 => хиляда и сто
        # 100_101 => хиляда сто и едно
        if triplets.last.include?(SEPARATOR)
          triplets.join(' ')
        else
          triplets[0...-1].join(' ') + separator + triplets.last
        end
      end
    end
  end
end
