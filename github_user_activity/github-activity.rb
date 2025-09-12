require "net/http"
require "json"
require_relative "./lib/presenter"

if ARGV.length > 0
  nickname = ARGV[0].strip
else
  print "Type nickname: "
  nickname = gets.strip
end

raise "nickname cannot be empty!" if nickname.empty?

uri = URI("https://api.github.com/users/#{nickname}/events")

begin
  response = Net::HTTP.get_response(uri)

  case response
  when Net::HTTPSuccess
    data = JSON.parse(response.body)
    if data.empty?
      puts "No events found for user #{nickname}"
    else
      puts Presenter.new(data).present_events
    end
  when Net::HTTPForbidden
    reset_epoch = response["X-RateLimit-Reset"].to_i
    wait_minutes = ((reset_epoch - Time.now.to_i) / 60.0).ceil
    puts "Rate limit exceeded. Try again in #{wait_minutes} minutes (at #{Time.at(reset_epoch)})."
  when Net::HTTPNotFound
    puts "User '#{nickname}' not found"
  else
    puts "Error: #{response.code} #{response.message}"
  end
rescue => e
  puts e.message
end
