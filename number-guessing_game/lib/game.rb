require_relative "timer"
require_relative "dashboard"

class Game
  attr_reader :player, :guess, :level, :attempts, :max_attempts, :time_in_sec, :result

  LEVELS = {
    1 => { attempts: 10, text: "Great! You have selected the Easy difficulty level.\nLet's start the game!" },
    2 => { attempts: 5, text: "Great! You have selected the Medium difficulty level.\nLet's start the game!" },
    3 => { attempts: 3, text: "Great! You have selected the Hard difficulty level.\nLet's start the game!" },
  }

  def initialize(name = "unknownHERO")
    @player = name
    @guess = rand(1..100)
    @level = 2
    @attempts = 0
    @max_attempts = 5
    @time_in_sec = 0
    @result = nil
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
    # puts @guess #for testing
    start = Timer.new
    loop do
      if @attempts == @max_attempts
        puts "Sorry you lose =*("
        @result = 0
        break
      end
      print "Enter your guess: "
      g = gets.strip.to_i
      @attempts += 1

      if g < @guess
        puts "Incorrect! The number is greater than #{g}."
      elsif g > @guess
        puts "Incorrect! The number is less than #{g}."
      elsif @guess == g
        puts "Congratulations! You guessed the correct number in #{@attempts} attempts."

        finish = Timer.new
        @time_in_sec = start.diff(finish)
        @result = 1
        break
      end
    end
  end

  def to_h
    {
      player: player,
      guess: guess,
      level: level,
      attempts: attempts,
      max_attempts: max_attempts,
      time_in_sec: time_in_sec,
      result: result,
    }
  end
end
