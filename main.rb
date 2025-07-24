require 'bundler/setup'
require_relative 'console_styling'
require_relative 'agent'

Bundler.require

agent = Agent.new

puts "Chat with Claude Sonnet 4 (type '/q' to quit):"

take_user_input = true
loop do
  message = if take_user_input
              print colored_label_string('You', '', :blue)
              user_input = gets
              user_input = user_input.strip
              exit if user_input == '/q'

              agent.run_infrence(user_input)
            else
              agent.run_infrence
            end

  tool_use_count = 0
  message.content.each do |part|
    if part[:type] == :text
      puts colored_label_string('Claude', part[:text], :yellow) if part[:text]
    elsif part[:type] == :tool_use
      puts colored_label_string('Tool request from claud', part[:tool_use][:name], :magenta)
      tool_use_count += 1
      # run tool
      # add tool result to conversation
    else
      puts colored_label_string('Error', "Unknown message part type: #{part.inspect}", :red)
    end
  end

  take_user_input = tool_use_count.zero?
end
