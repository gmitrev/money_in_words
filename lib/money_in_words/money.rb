# encoding: utf-8
module MoneyInWords
  class Money
    attr_accessor :levs, :stotinki

    LEVS = {
      zero: 'лева',
      one: 'лев',
      many: 'лева'
    }

    STOTINKI = {
      zero: 'стотинки',
      one: 'стотинка',
      many: 'стотинки'
    }

    def initialize(num, options = {})
      @num = num
      @levs, @stotinki = split_number

      @levs = @levs.to_i
      @stotinki = @stotinki.ljust(2, '0').to_i

      @options = {
        show_zero_leva: true,
        show_zero_stotinki: false
      }.merge(options)
    end

    def to_words
      [leva_to_words, stotinki_to_words].compact.join(' и ')
    end

    private

    def split_number
      @num.to_s.split('.')
    end

    def levs_suffix
      if @levs == 0
        LEVS[:zero]
      elsif @levs == 1
        LEVS[:one]
      else
        LEVS[:many]
      end
    end

    def stotinki_suffix
      if @stotinki == 0
        STOTINKI[:zero]
      elsif @stotinki == 1
        STOTINKI[:one]
      else
        STOTINKI[:many]
      end
    end

    def leva_to_words
      if @levs == 0 && !@options[:show_zero_leva]
        nil
      else
        @levs.to_words + ' ' + levs_suffix
      end
    end

    def stotinki_to_words
      if @stotinki == 0 && !@options[:show_zero_stotinki]
        nil
      else
        @stotinki.to_words(article: :female) + ' ' + stotinki_suffix
      end
    end
  end
end
