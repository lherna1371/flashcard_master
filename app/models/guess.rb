class Guess < ActiveRecord::Base
  belongs_to :rounds
  belongs_to :cards
  # Remember to create a migration!

  
end
