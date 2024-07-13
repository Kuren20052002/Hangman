require_relative "man"

# The mastermind
class Game
  def initialize(number_of_guesses_made = 0, answer = pick_random_word)
    @number_of_guesses_made = number_of_guesses_made
    @guessed_words = []
    @guess = guess
    @answer = answer
  end

  def pick_random_word
    @answer = File.readlines("Words.txt").sample.split
    @guess = Array.new(@answer.length)
  end

  def check_result
    if guess == answer
      puts "You won!"
      1
    elsif number_of_guesses_made == 8
      puts "You lose"
      -1
    else
      0
    end
  end

  def reset
    @number_of_guesses_made = 0
    @guessed_words.push(@answer.join)
    pick_random_word
  end

  def show_guessed_char
    @guess.each do |letter|
      if letter
        puts "#{letter} "
      else
        puts "_ "
      end
    end
  end

  def fetch_guess
    loop do
      puts "Input guess"
      input = gets.chomp
      return input if input.length == 1 && input.match?(/\D/)
    end
  end

  def start_game
    while true

    end
  end
end
