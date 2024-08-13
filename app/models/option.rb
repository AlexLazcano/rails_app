class Option < ApplicationRecord
  belongs_to :poll

  before_validation :set_default_votes, on: :create

  validates :text, presence: true
  validates :votes, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  private

  def set_default_votes
    self.votes ||= 0
  end
end
