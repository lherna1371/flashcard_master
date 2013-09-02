class Round < ActiveRecord::Base
  belongs_to :user
  belongs_to :deck
  validate :is_finished?
  # belongs_to :cards, through: :guesses

  def is_finished?
    if self.is_finished == true
      errors.add(:score ,"This round is expired." )
    end
  end
end
