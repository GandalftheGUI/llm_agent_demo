# LLM Agent Demo

This project demonstrates how to build a simple agent that utilizes Anthropic's Claude LLM to combine multiple tools in order to achieve complex results. This agent can inspect its own codebase with two commands "list_files" and "read_file". For example, you can ask the agent to "find the definition of some_method_name and tell me about it", the LLM will use its toolset to locate the method and provide an explanation.

This was very much inspired by https://ampcode.com/how-to-build-an-agent

Here are a couple examples:

```
🙋‍♂️ You: where is 'run_inference' method defined and what does its code look like?
🤖 Claude: I'll help you find the `run_inference` method. Let me start by exploring the current directory structure to understand the codebase layout.
🛠️ Tool request from claud: list_files({:directory=>"."})
🤖 Claude: Let me search through the Ruby files to find the `run_inference` method:
🛠️ Tool request from claud: read_file({:path=>"main.rb"})
🤖 Claude: I can see that `run_inference` is called on the `agent` object. Let me check the `agent.rb` file:
🛠️ Tool request from claud: read_file({:path=>"agent.rb"})
🤖 Claude: Perfect! I found the `run_inference` method. Here's the information you requested:

## Location
The `run_inference` method is defined in the `Agent` class in the file `agent.rb`.

## Code
```ruby
def run_inference
  message = @anthropic_client.messages.create(
    max_tokens: MAX_TOKENS,
    messages: @conversation,
    model: MODEL,
    tools: @
```

```
🙋‍♂️ You: what are some ways i can improve the codebase?
🤖 Claude: I'd be happy to help you identify ways to improve the codebase! First, let me explore the current structure to understand what we're working with.
🛠️ Tool request from claud: list_files({:directory=>"."})
🤖 Claude: Let me examine the main files to understand the codebase structure and functionality:
🛠️ Tool request from claud: read_file({:path=>"README.md"})
🛠️ Tool request from claud: read_file({})
🛠️ Tool request from claud: read_file({:path=>"main.rb"})
🛠️ Tool request from claud: read_file({:path=>"agent.rb"})
🛠️ Tool request from claud: read_file({:path=>"tooling.rb"})
🛠️ Tool request from claud: read_file({:path=>"console_styling.rb"})
🛠️ Tool request from claud: read_file({:path=>"Gemfile"})
🤖 Claude: Based on my analysis of the codebase, here are several ways you can improve this LLM agent demo:

## 🏗️ **Architecture & Structure**

1. **Extract Configuration**
   - Move constants like `MODEL`, `MAX_TOKENS` to a dedicated config file
   - Add configuration validation and environment-specific settings

2. **Improve Error Handling**
   - Add proper exception classes instead of generic error strings
```


## Features
- Chat with Claude Sonnet 4 via the Anthropic API
- Tool use: read files, list directories, and more
- Claude can combine tools to answer multi-step questions
- Colorful console output for easy reading

## Setup

### 1. Clone the repository
```sh
git clone <repo-url>
cd llm_agent_demo
```

### 2. Install dependencies
This project uses [Bundler](https://bundler.io/):
```sh
bundle install
```

### 3. Create a `.env` file
This project uses [dotenv](https://github.com/bkeepers/dotenv) to load environment variables. You must provide your Anthropic API key.

Create a file named `.env` in the project root with the following content:

```
ANTHROPIC_API_KEY=your_anthropic_api_key_here
```

**Note:** Never commit your `.env` file. It is already in `.gitignore`.

### 4. Run the application
```sh
ruby main.rb
```

You will see a prompt:
```
Chat with Claude Sonnet 4 (type '/q' to quit):
```
Type your message and press Enter to chat. Type `/q` to exit.

## Tooling
Claude can request tools such as reading files or listing directories. The agent can chain these tools together to answer more complex questions, such as finding and explaining code definitions.

## Requirements
- Ruby 3.0+
- Bundler
- An Anthropic API key ([get one here](https://console.anthropic.com/))

## License
MIT 
