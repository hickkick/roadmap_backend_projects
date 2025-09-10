class CliError < StandardError; end
class InvalidCommandError < CliError; end
class InvalidArgumentError < CliError; end
class MissingArgumentError < CliError; end

class CliParser
  attr_reader :params

  COMMANDS = {
    "add" => { args: 1, required: [:description] },
    "update" => { args: 2, required: [:id, :description] },
    "delete" => { args: 1, required: [:id] },
    "list" => { args: 0..1, optional: [:status], allowed_values: { status: ["todo", "in-progress", "done"] } },
    "mark-done" => { args: 1, required: [:id] },
    "mark-in-progress" => { args: 1, required: [:id] },
    "--help" => { args: 0 },
  }

  def initialize(args)
    validate_command(args)
    validate_arguments(args)
    @params = parse_arguments(args)
  end

  def self.show_usage
    puts <<~USAGE
           Usage: ruby task-cli.rb <command> [arguments]
           
           Commands:
             add <description>           Add new task
             update <id> <description>   Update existing task  
             delete <id>                 Delete task
             list [status]              List tasks (optionally filter by status)
             mark-done <id>             Mark task as done
             mark-in-progress <id>      Mark task as in progress
             
           Examples:
             ruby task-cli.rb add "Buy groceries"
             ruby task-cli.rb update 1 "Buy organic groceries"  
             ruby task-cli.rb list done
             ruby task-cli.rb mark-done 1
         USAGE
  end

  private

  def validate_command(args)
    raise InvalidCommandError, "No command provided" if args.empty?

    command = args[0]
    unless COMMANDS.key?(command)
      raise InvalidCommandError, "Unknown command: #{command}. Available: #{COMMANDS.keys.join(", ")}"
    end
  end

  def validate_arguments(args)
    command = args[0]
    config = COMMANDS[command]
    arg_count = args.size - 1

    case config[:args]
    when Integer
      raise MissingArgumentError, "#{command} requires exactly #{config[:args]} argument(s)" if arg_count != config[:args]
    when Range
      raise MissingArgumentError, "#{command} requires #{config[:args]} argument(s)" unless config[:args].include?(arg_count)
    end

    # Валідація ID
    if config[:required]&.include?(:id)
      id = args[1]
      raise InvalidArgumentError, "ID must be a number" unless id&.match?(/^\d+$/)
    end

    # Валідація опису
    if config[:required]&.include?(:description)
      desc = args[-1]
      raise InvalidArgumentError, "Description cannot be empty" if desc.nil? || desc.strip.empty?
    end

    # Валідація фільтра
    if command == "list" && args[1]
      status = args[1]
      allowed = config[:allowed_values][:status]
      unless allowed.include?(status)
        raise InvalidArgumentError, "Invalid status '#{status}'. Allowed: #{allowed.join(", ")}"
      end
    end
  end

  def parse_arguments(args)
    {
      command: args[0],
      option: args[1],
      text: args[2],
    }
  end
end
