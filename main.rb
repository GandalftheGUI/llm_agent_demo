require 'bundler/setup'
require_relative 'console_styling'
require_relative 'agent'

Bundler.require

agent = Agent.new

puts "Chat with Claude Sonnet 4 (type '/q' to quit):"

loop do
  print colored_label_string('You', '', :blue)
  user_input = gets
  user_input = user_input.strip

  break if user_input == '/q'

  message = agent.run_infrence(user_input)

  message.content.each do |part|
    if part[:type] == :text
      puts colored_label_string('Claude', part[:text], :yellow) if part[:text]
    elsif part[:type] == :tool_use
      puts colored_label_string('Tool request from claud', part[:tool_use][:name], :magenta)
    else
      puts colored_label_string('Error', part.inspect, :red)
    end
  end
end
