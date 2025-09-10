require "json"
require_relative "task"

class Todo
  FILENAME = "todo's.json"

  def create_item(options)
    data = load
    id = set_id(data)
    task = Task.new(options, id)
    save data.concat([task.to_h])
    puts "Task added successfully (ID: #{id})"
  end

  def update_item(id)
    data = load
    item = find_id(data, id.to_i)
    raise "Element not found =*(" if item.nil?

    yield(item)
    item["updatedAt"] = Time.now
    data[item["id"] - 1] = item
    save data
    puts "Changes was save."
  end

  def update_descr(id, text)
    update_item(id) { |item| item["description"] = text }
  end

  def change_status(id, command)
    status = command.gsub("mark-", "")
    update_item(id) { |item| item["status"] = status }
  end

  def delete_item(id)
    data = load
    item = find_id(data, id.to_i)
    raise "Element not found =*(" if item.nil?

    pop = data.delete(data[item["id"] - 1])
    save data
    puts "Element '#{pop["description"]}' was deleted."
  end

  def list(status)
    p status
    data = status ? load.find_all { |el| el["status"] == status } : load
    data.each { |el| el.each { |key, val| puts "#{key}: #{val}" } }
  end

  private

  def find_id(data, id)
    data.find { |item| item["id"] == id }
  end

  def load
    data = File.exist?(FILENAME) ? JSON.parse(File.read(FILENAME)) : []
  end

  def save(data)
    File.write(FILENAME, JSON.pretty_generate(data))
  end

  def set_id(data)
    data.empty? ? 1 : data.map { |item| item["id"] }.max + 1
  end
end
