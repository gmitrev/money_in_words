# encoding: utf-8
require 'bundler/setup'
Bundler.setup

require 'money_in_words'

RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.filter_run_excluding :brute

  config.order = 'random'
end
