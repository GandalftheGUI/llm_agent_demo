COLOR_CODES = {
  red: 91,
  green: 92,
  yellow: 93,
  blue: 94,
  magenta: 95,
  cyan: 96,
  white: 97
}

def colored_label_string(label, message, color = :green)
  color_code = COLOR_CODES[color] || 97
  "\u001b[#{color_code}m#{label}\u001b[0m: #{message}"
end
