class Tooling
  @tools = [
    {
      name: "read_file",
      description: "Reads the contents of a file from disk",
      parameters: {
        type: "object",
        properties: {
          path: {
            type: "string",
            description: "The path to the file to read"
          }
        },
        required: ["path"]
      }
    }
  ]

  attr_reader :tools

  def run_tool(tool_name, params)
    case tool_name
    when "read_file"
      read_file(params)
    else
      raise "Unknown tool: #{tool_name}"
    end
  end

  def read_file(params)
    path = params["path"]
    raise "File path is required" unless path

    begin
      # ensure file path is relative
      content = File.read(File.expand_path(path))
      { success: true, content: content }
    rescue Errno::ENOENT
      { success: false, error: "File not found: #{path}" }
    rescue => e
      { success: false, error: "Error reading file: #{e.message}" }
    end
  end
end