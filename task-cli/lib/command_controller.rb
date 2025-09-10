class CommandController
  attr_reader :command, :option, :text

  def initialize(options)
    @command = options[:command]
    @option = options[:option]
    @text = options[:text]
  end

  def call(todo)
    case command
    when "add"
      todo.create_item @option
    when "update"
      todo.update_descr @option, @text
    when "delete"
      todo.delete_item @option
    when "mark-in-progress", "mark-done"
      todo.change_status @option, @command
    when "list"
      todo.list @option
    when "--help"
      CliParser.show_usage
    end
  end
end
