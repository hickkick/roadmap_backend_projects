require "json"

class Dashboard
  FILENAME = File.join(__dir__, "..", "scores.json")

  def initialize
    @data = File.exist?(FILENAME) ? JSON.parse(File.read(FILENAME)) : []
  end

  def save
    File.write(FILENAME, JSON.pretty_generate(@data))
  end
end
