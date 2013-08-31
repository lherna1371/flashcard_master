class Guess < ActiveRecord::Base
  belongs_to :rounds
  belongs_to :cards
  # Remember to create a migration!

  def determine_correctness
    self.correctness = true if self.card.answer.downcase == game[answer].downcase
  end
end
