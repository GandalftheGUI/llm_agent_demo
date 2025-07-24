# Agent class description
# This class is responsible for managing the conversation with the Anthropic API.

require 'dotenv/load'
require 'anthropic'
require_relative 'tooling'

MODEL = 'claude-sonnet-4-20250514'.freeze
MAX_TOKENS = 100

class Agent
  def initialize
    @conversation = []
    @tooling = Tooling.new
    @anthropic_client = Anthropic::Client.new(
      api_key: ENV['ANTHROPIC_API_KEY']
    )
  end

  def add_to_conversation(role, content)
    @conversation << { role: role, content: content }
  end

  def add_tool_result(tool_use_id, content)
    tool_result = {
      role: 'user',
      content: [{
        content: content,
        type: :tool_result,
        tool_use_id: tool_use_id
      }]
    }
    @conversation << tool_result
  end

  def run_inference
    message = @anthropic_client.messages.create(
      max_tokens: MAX_TOKENS,
      messages: @conversation,
      model: MODEL,
      tools: @tooling.tools
    )

    @conversation << { role: message.role, content: message.content }

    message
  end

  def client
    @anthropic_client
  end

  def conversation_history
    @conversation
  end
end
