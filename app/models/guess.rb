class Guess < ActiveRecord::Base
  belongs_to :round
  belongs_to :card
  # Remember to create a migration!

  
end
