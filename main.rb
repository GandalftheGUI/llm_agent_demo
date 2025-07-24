require 'bundler/setup'
require_relative 'console_styling'
require_relative 'agent'

Bundler.require

agent = Agent.new
tooling = Tooling.new
take_user_input = true

puts "Chat with Claude Sonnet 4 (type '/q' to quit):"

loop do
  if take_user_input
    print colored_label_string('🙋‍♂️ You', '', :blue)
    user_input = gets
    user_input = user_input.strip
    exit if user_input == '/q'

    agent.add_to_conversation('user', user_input)
  end

  message = agent.run_inference

  tool_use_count = 0
  message.content.each do |part|
    if part[:type] == :text
      puts colored_label_string('🤖 Claude', part[:text], :yellow) if part[:text]
    elsif part[:type] == :tool_use
      puts colored_label_string('🛠️ Tool request from claud', "#{part[:name]}(#{part[:input]})", :green)

      tool_use_count += 1
      results = tooling.run_tool(part[:name], part[:input])
      #puts colored_label_string('Tool result', results, :magenta).truncate(100)
      agent.add_tool_result(part[:id], results)
    else
      puts colored_label_string('Error', "Unknown message part type: #{part.inspect}", :red)
    end
  end

  take_user_input = tool_use_count.zero?
end
