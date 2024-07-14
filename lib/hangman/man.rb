# Drawing of hangman in every stage
class Man
  attr_reader :hangman_stages

  def initialize
    @hangman_stages = [
      "\n  +---+\n  |   |\n      |\n      |\n      |\n      |\n=========",
      "\n  +---+\n  |   |\n  O   |\n      |\n      |\n      |\n=========",
      "\n  +---+\n  |   |\n  O   |\n  |   |\n      |\n      |\n=========",
      "\n  +---+\n  |   |\n  O   |\n /|   |\n      |\n      |\n=========",
      "\n  +---+\n  |   |\n  O   |\n /|\\  |\n      |\n      |\n=========",
      "\n  +---+\n  |   |\n  O   |\n /|\\  |\n /    |\n      |\n=========",
      "\n  +---+\n  |   |\n  O   |\n /|\\  |\n / \\  |\n      |\n=========",
      "\n  +---+\n  |   |\n  X   |\n /|\\  |\n / \\  |\n      |\n========="
    ]
    @won = "  +---+\n  |   |\n  \\O/ |\n   |  |\n  / \\ |\n      |\n========="
  end
end
