class Round < ActiveRecord::Base
  belongs_to :users
  belongs_to :decks
  belongs_to :cards, through: :guesses


  def calculate_score
    correct_guesses = self.guesses.where(correctness: true).count
    total_guesses = self.guesses.count
    self.score = ((correct_guesses.to_f / total_guesses) * 100).to_i
    self.save 
  end

  def incorrect_guesses
    self.guesses.where(correctness: nil)
  end
end
