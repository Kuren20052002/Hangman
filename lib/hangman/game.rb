require_relative 'man'
require 'pry-byebug'
require 'yaml'

# The mastermind
class Game
  def initialize
    @number_of_wront_guesses_made = 0
    @guessed_words = []
    @correct_guesses = []
    pick_random_word
    @man = Man.new
    @guessed_char = []
    start_menu
  end

  def pick_random_word
    loop do
      answer = File.readlines('Words.txt').sample.chomp.chars

      unless @guessed_words.include?(answer.join)
        @answer = answer
        break
      end
    end

    @guessed_words.push(@answer.join)
    @correct_guesses = Array.new(@answer.length)
  end

  def check_result
    if @correct_guesses == @answer
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

    @correct_guesses.each_with_index do |letter, index|
      if letter && index == 0
        print "#{letter.upcase} "
      elsif letter
        print "#{letter} "
      else
        print '_ '
      end
    end
  end

  def save_game
    File.open('save.yaml', 'w') do |file|
      YAML.dump({
                  number_of_wront_guesses_made: @number_of_wront_guesses_made,
                  guessed_words: [@answer.join.to_s],
                  correct_guesses: @correct_guesses,
                  answer: @answer,
                  guessed_char: @guessed_char
                }, file)
    end
    puts 'Game saved!'
  end

  def load_save
    if File.exist?('save.yaml')
      data = YAML.load_file('save.yaml')
      @number_of_wront_guesses_made = data[:number_of_wront_guesses_made]
      @guessed_words = data[:guessed_words]
      @correct_guesses = data[:correct_guesses]
      @answer = data[:answer]
      @guessed_char = data[:guessed_char]
      puts "Save loaded!\n Press any key to continue"
      gets.chomp
      start_game
    else
      "Save file doesn't exist."
    end
  end

  def start_menu
    puts 'Welcome to Hangman!'
    puts  "\nGet ready to play the classic word-guessing game!"
    puts  "Can you solve the mystery word before it's too late?"
    puts  "\nEnter '1' to start a new game."
    puts  "Enter '2' to load a saved game."
    puts  'Enter else to cancel.'
    input = gets.chomp
    if input == '1'
      start_game
    elsif input == '2'
      load_save
    end
    puts 'Bye bye!'
  end

  def handle_save_input(input)
    if input == 'save' && !@guessed_char.empty?
      save_game
      return true
    elsif input == 'save'
      puts "You can't save in the very first turn! Make a guess!"
    end
    false
  end

  def fetch_input
    puts "\nInput a single non-digit character:\nType 'Save' if you want to save"

    loop do
      input = gets.chomp.downcase
      return input if handle_save_input(input)
      next if input == 'save'

      if input.length == 1 && input.match?(/\D/) && !@guessed_char.include?(input)
        @guessed_char.push(input)
        return input
      else
        puts "Invalid input. Please input a single non-digit character that hasn't been guessed or retype 'save'."
      end
    end
  end

  def handle_guess
    show_guessed_char
    input = fetch_input
    return input if input == 'save'

    wrong = false
    @answer.each_with_index do |letter, index|
      if input == letter
        @correct_guesses[index] = input
        wrong = true
      end
    end

    @number_of_wront_guesses_made += 1 unless wrong
  end

  def start_game
    loop do
      return nil if handle_guess == 'save'
      next unless check_result

      puts 'Would you like to play again?'
      return nil unless gets.chomp.downcase == 'yes'

      reset
    end
  end
end
