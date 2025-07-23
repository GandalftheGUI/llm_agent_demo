gem 'dotenv'

# app.rb
require 'dotenv/load'
api_key = ENV['CLAUD_API_KEY']

puts api_key