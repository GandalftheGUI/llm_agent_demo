class Tooling
  TOOLS = [
    {
      name: "read_file",
      description: "Read the contents of a given relative file path. Use this when you want to see what's inside a file. Do not use this with directory names.",
      input_schema: {
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

  def tools
    TOOLS
  end

  def run_tool(tool_name, params)
    case tool_name
    when "read_file"
      read_file(params)
    else
      raise "Unknown tool: #{tool_name}"
    end
  end

  def read_file(params)
    path = params[:path]
    raise "File path is required" unless path

    begin
      # ensure file path is relative
      File.read(File.expand_path(path))
    rescue Errno::ENOENT
      { success: false, error: "File not found: #{path}" }
    rescue => e
      { success: false, error: "Error reading file: #{e.message}" }
    end
  end
end