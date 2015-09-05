# encoding: utf-8
require 'spec_helper'

describe 'Money' do

  fixtures = [
    [0, 'нула лева'],
    [0.5, 'нула лева и петдесет стотинки'],
    [1, 'един лев'],
    [1.2, 'един лев и двадесет стотинки'],
    [2.22, 'два лева и двадесет и две стотинки'],
    [3.99, 'три лева и деветдесет и девет стотинки'],
    [4.01, 'четири лева и една стотинка'],
    [5.11, 'пет лева и единадесет стотинки'],
    [2500.08, 'две хиляди и петстотин лева и осем стотинки']
  ]

  fixtures.each do |f|
    it "example #{f.first} " do
      expect(f.first.to_money).to eq f.last
    end

    it "example with BigDecimal #{f.first} " do
      expect(BigDecimal.new(f.first.to_s).to_money).to eq f.last
    end
  end

  it 'example 3 without stotinki' do
    expect(3.to_money(show_zero_stotinki: false)).to eq 'три лева'
  end

  it 'example 3 with stotinki' do
    expect(3.to_money(show_zero_stotinki: true)).to eq 'три лева и нула стотинки'
  end

  it 'example 0.50 with leva' do
    expect(0.5.to_money(show_zero_leva: true)).to eq 'нула лева и петдесет стотинки'
  end

  it 'example 0.50 without leva' do
    expect(0.5.to_money(show_zero_leva: false)).to eq 'петдесет стотинки'
  end
end
