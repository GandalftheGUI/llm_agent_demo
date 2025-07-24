# LLM Agent Demo

This project demonstrates how to build a simple agent that utilizes Anthropic's Claude LLM to combine multiple tools in order to achieve complex results. For example, you can ask the agent to "find the definition of some_method_name and tell me about it"—the LLM will use its toolset (such as file reading and directory listing) to locate the method and provide an explanation.

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