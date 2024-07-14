require_relative "man"
require "pry-byebug"
# The mastermind
class Game
  def initialize
    @number_of_wront_guesses_made = 0
    @guessed_words = []
    @guess = []
    pick_random_word
    @man = Man.new
    @guessed_char = []
  end

  def pick_random_word
    loop do
      answer = File.readlines("Words.txt").sample.chomp.chars

      unless @guessed_words.include?(answer.join)
        @answer = answer
        break
      end
    end

    @guessed_words.push(@answer.join)
    @guess = Array.new(@answer.length)
  end

  def check_result
    if @guess == @answer
      puts "\nCongratulations! You guessed the word: #{@answer.join.capitalize}"
      1
    elsif @number_of_wront_guesses_made == 7
      puts "#{@man.hangman_stages[@number_of_wront_guesses_made]}
            \nYou lose, the answer is #{@answer.join}"
      -1
    else
      false
    end
  end

  def reset
    @number_of_wront_guesses_made = 0
    @guessed_char = []
    pick_random_word
  end

  def show_guessed_char
    puts "-----------------------------------
         #{@man.hangman_stages[@number_of_wront_guesses_made]}"

    @guess.each_with_index do |letter, index|
      if letter && index == 0
        print "#{letter.upcase} "
      elsif letter
        print "#{letter} "
      else
        print "_ "
      end
    end
  end

  def fetch_input
    puts "\nInput a single non-digit character:"
    loop do
      input = gets.chomp.downcase
      if input.length == 1 && input.match?(/\D/) && !@guessed_char.include?(input)
        @guessed_char.push(input)
        return input
      else
        puts "Invalid input. Please input a single non-digit character that hasn't been guessed."
      end
    end
  end

  def handle_guess
    show_guessed_char
    input = fetch_input
    wrong = false
    @answer.each_with_index do |letter, index|
      if input == letter
        @guess[index] = input
        wrong = true
      end
    end
    @number_of_wront_guesses_made += 1 unless wrong
  end

  def start_game
    loop do
      handle_guess
      next unless check_result

      puts "Would you like to play again?"
      return nil unless gets.chomp.downcase == "yes"

      reset
    end
  end
end
