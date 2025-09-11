require "json"

class Dashboard
  FILENAME = File.join(__dir__, "..", "scores.json")

  def initialize
    @data = File.exist?(FILENAME) ? JSON.parse(File.read(FILENAME), symbolize_names: true) : []
  end

  def add(scores)
    @data.push(scores)
  end

  def make
    rows = @data.sort_by { |e| [-e[:level], e[:attempts], e[:time_in_sec]] }[0..9]
    format = "| %2s | %-12s | %10s | %10s | %6s |\n"

    header = format % ["#", "Player", "Attempts", "Time", "Level"]
    line = "-" * header.size

    output = ""
    output << "=== Best Scores Result ===\n\n"
    output << line + "\n"
    output << header
    output << line + "\n"

    rows.each_with_index do |el, i|
      output << format % [i + 1, el[:player], el[:attempts], el[:time_in_sec], el[:level]]
      output << line + "\n"
    end

    output
  end

  def save
    File.write(FILENAME, JSON.pretty_generate(@data))
  end
end
