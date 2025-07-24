## Agent class description
## This class is responsible for managing the conversation with the Anthropic API.

require 'dotenv/load'
require 'anthropic'

MODEL = 'claude-sonnet-4-20250514'.freeze
MAX_TOKENS = 100

class Agent
  def initialize
    @conversation = []
    @anthropic_client = Anthropic::Client.new(
      api_key: ENV['ANTHROPIC_API_KEY']
    )
  end

  def add_to_conversation(role, content)
    @conversation << { role: role, content: content }
  end

  def run_infrence(user_input = nil)
    add_to_conversation('user', user_input) if user_input.present?
  
    message = @anthropic_client.messages.create(
      max_tokens: MAX_TOKENS,
      messages: @conversation,
      model: MODEL
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
