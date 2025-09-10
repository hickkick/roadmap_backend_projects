require_relative "./lib/cli_parser"
require_relative "./lib/command_controller"
require_relative "./lib/todo"

begin
  options = CliParser.new(ARGV).params
  todo = Todo.new
  CommandController.new(options).call todo
rescue CliError => e
  puts e.message
  puts "Type $ 'ruby task-cli.rb --help' for more information"
rescue => e
  puts e.message
end
