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
    },
    {
      name: "list_files",
      description: "List the files in a given directory. Use this when you want to see what files or folders exist in a location.",
      input_schema: {
        type: "object",
        properties: {
          directory: {
            type: "string",
            description: "The relative path to the directory to list"
          }
        },
        required: ["directory"]
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
    when "list_files"
      list_files(params)
    else
      raise "Unknown tool: #{tool_name}"
    end
  end

  def read_file(params)
    relative_path = params[:path] || params["path"]
    return error("File path is required") unless relative_path
    return error("Absolute paths are not allowed") if absolute_path?(relative_path)
    return error("Parent directory traversal is not allowed") if upward_path?(relative_path)

    full_path = File.expand_path(relative_path)

    begin
      File.read(full_path)
    rescue Errno::ENOENT
      error("File not found: #{relative_path}")
    rescue => e
      error("Error reading file: #{e.message}")
    end
  end

  def list_files(params)
    relative_path = params[:directory] || params["directory"]
    return error("Directory path is required") unless relative_path
    return error("Absolute paths are not allowed") if absolute_path?(relative_path)
    return error("Parent directory traversal is not allowed") if upward_path?(relative_path)

    full_path = File.expand_path(relative_path)

    begin
      Dir.entries(full_path).reject { |f| f.start_with?('.') }.to_s
    rescue Errno::ENOENT
      error("Directory not found: #{relative_path}")
    rescue => e
      error("Error listing files: #{e.message}")
    end
  end

  def absolute_path?(path)
    Pathname.new(path).absolute?
  end

  def upward_path?(path)
    path.include?("..")
  end

  def error(msg)
    { success: false, error: msg }
  end
end