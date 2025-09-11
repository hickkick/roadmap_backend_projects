require_relative "./lib/game"

puts "Welcome to the Number Guessing Game!\nI'm thinking of a number between 1 and 100.\nYou have 5 chances to guess the correct number."
print "Please enter your name: "
player_name = gets.strip
scores = Dashboard.new
repeats = 1

loop do
  puts "\n=== Main Menu ==="
  puts "1. Start new game"
  puts "2. Show leaderboard"
  puts "3. Exit\n\n"
  print "Choose an option: "
  choice = gets.strip

  case choice
  when "1"
    game = Game.new(player_name)
    game.set_level
    game.play

    scores.add(game.to_h)
    scores.save
    sleep 2
    puts "Round ##{repeats} finished."
    repeats += 1
    sleep 1
  when "2"
    puts scores.make
  when "3"
    puts "Goodbye, #{player_name}!"
    break
  else
    puts "Invalid option. Try again."
  end
end
