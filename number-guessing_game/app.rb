require_relative "./lib/game"

puts "Welcome to the Number Guessing Game!\nI'm thinking of a number between 1 and 100.\nYou have 5 chances to guess the correct number."
scores = Dashboard.new
sleep 1
repeats = 1
loop do
  game = Game.new
  game.set_level
  game.play
  sleep 1

  scores.add(game.to_h)
  scores.save

  puts "Round ##{repeats} finished."
  repeats += 1

  puts "Wanna try again? (y/n)"
  answer = gets.strip.downcase
  break unless ["y", "yes"].include?(answer)
end
puts scores.make
