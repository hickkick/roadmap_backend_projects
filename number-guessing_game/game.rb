require_relative "timer"
puts "Welcome to the Number Guessing Game!
      I'm thinking of a number between 1 and 100.
      You have 5 chances to guess the correct number."
guess = rand(1..100)
attempts = 5
level = 2

puts "Please select the difficulty level:
      1. Easy (10 chances)
      2. Medium (5 chances)
      3. Hard (3 chances)"

def set_level
  level = gets.strip.to_i
end

case set_level
when 1
  attempts = 10
  puts "Great! You have selected the Easy difficulty level.
        Let's start the game!"
when 2
  attempts = 5
  puts "Great! You have selected the Medium difficulty level.
        Let's start the game!"
when 3
  attempts = 3
  puts "Great! You have selected the Hard difficulty level.
        Let's start the game!"
else
  puts "You hit wrong keys, try again"
  set_level
end

start = Timer.new
loop do
  break if attempts < 1
  print "Enter your guess: "
  g = gets.strip.to_i

  if g < guess
    puts "Incorrect! The number is greater than #{g}."
    attempts -= 1
  elsif g > guess
    puts "Incorrect! The number is less than #{g}."
    attempts -= 1
  elsif guess == g
    puts "Congratulations! You guessed the correct number in #{attempts} attempts."
    finish = Timer.new
    delta = start.diff(finish)
    puts start.show(delta)
    puts "whanna play again?"
    restart = gets.strip
    if restart == "y" || "yes"
    end
  end
end
