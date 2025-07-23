require "bundler/setup"

Bundler.require

require 'dotenv/load'
require "anthropic"

anthropic = Anthropic::Client.new(
  api_key: ENV['ANTHROPIC_API_KEY']
)

# The API is stateless so we need to keep track of the conversation history ourselves.
conversation = []

ARGF.each do |user_input|
  user_input = user_input.strip

  break if user_input == '/q'

  conversation << {
    role: :user,
    content: user_input
  }

  message = anthropic.messages.create(
    max_tokens: 100,
    messages: conversation,
    model: :"claude-sonnet-4-20250514"
  )

  conversation << { role: message.role, content: message.content }

  message.content.each do |part|
    puts "\u001b[93mClaude\u001b[0m: #{part[:text]}" if part[:text]
  end
end