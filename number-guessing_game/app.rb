require_relative "game"

puts "Welcome to the Number Guessing Game!\nI'm thinking of a number between 1 and 100.\nYou have 5 chances to guess the correct number."
sleep 1
repeats = 1
loop do
  game = Game.new
  game.set_level
  game.play
  sleep 1

  puts "Round ##{repeats} finished."
  puts "Wanna try again? (y/n)"
  answer = gets.strip.downcase
  break unless ["y", "yes", "Y", "YES", "Yes"].include?(answer)
end
