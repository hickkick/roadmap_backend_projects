require_relative "timer"
require_relative "dashboard"

class Game
  LEVELS = {
    1 => { attempts: 10, text: "Great! You have selected the Easy difficulty level.\nLet's start the game!" },
    2 => { attempts: 5, text: "Great! You have selected the Medium difficulty level.\nLet's start the game!" },
    3 => { attempts: 3, text: "Great! You have selected the Hard difficulty level.\nLet's start the game!" },
  }

  def initialize
    @guess = rand(1..100)
    @level = 2
    @attempts = 1
    @max_attempts = 5
  end

  def set_level
    loop do
      puts "Please select the difficulty level: \n1. Easy (10 chances)\n2. Medium (5 chances)\n3. Hard (3 chances)"
      choice = gets.strip.to_i
      if LEVELS[choice]
        @level = LEVELS.key(LEVELS[choice])
        @max_attempts = LEVELS[choice][:attempts]
        puts LEVELS[choice][:text]
        break
      else
        puts "You hit wrong keys, try again"
      end
    end
  end

  def play
    puts @guess
    start = Timer.new
    loop do
      if @attempts == @max_attempts
        puts "Sorry you lose =*("
        break
      end
      print "Enter your guess: "
      g = gets.strip.to_i

      if g < @guess
        puts "Incorrect! The number is greater than #{g}."
        @attempts += 1
      elsif g > @guess
        puts "Incorrect! The number is less than #{g}."
        @attempts += 1
      elsif @guess == g
        puts "Congratulations! You guessed the correct number in #{@attempts} attempts."

        finish = Timer.new
        delta = start.diff(finish)
        p delta
        break
      end
    end
  end
end
