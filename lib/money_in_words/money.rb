require 'pry'
module MoneyInWords
  class Money

    attr_accessor :levs, :stotinki

    def initialize(num, options={})
      @num = num
      @levs, @stotinki = split_number
    end

    def to_words
      leva     = to_leva(@levs.to_i)
      stotinki = to_stotinki(@stotinki.ljust(2, '0').to_i)

      join(leva, stotinki)
    end

    def split_number
      @num.to_s.split(".")
    end

    def to_leva(num)
      num.to_words
    end

    def to_stotinki(num)
      num.to_words(article: :female)
    end

    def join(leva, stotinki)
      leva_str = case @levs.to_i
                 when 1
                   'лев'
                 else
                   'лева'
                 end

     stotinki_str = case @stotinki.to_i
         when 1
           'стотинка'
         else
           'стотинки'
         end

      if @levs.to_i != 0 && @stotinki.to_i != 0
        leva + " " + leva_str + " и " + stotinki + " " + stotinki_str
      elsif @stotinki.to_i == 0
        leva + " " + leva_str
      elsif @leva.to_i == 0
        stotinki + " " + stotinki_str
      end
    end


  end
end
