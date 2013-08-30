class Round < ActiveRecord::Base
  belongs_to :users
  belongs_to :decks
  belongs_to :cards, through: :guesses
  # Remember to create a migration!
end
