require_relative "man"

# The mastermind
class Game
  def initialize(number_of_guesses_made = 0, answer = pick_random_word)
    @number_of_guesses_made = number_of_guesses_made
    @guessed_words = []
    @guess = guess
    @answer = answer
  end
end
