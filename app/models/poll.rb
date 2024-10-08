class Poll < ApplicationRecord
  has_many :options, dependent: :destroy
  accepts_nested_attributes_for :options, allow_destroy: true
  validates :question, presence: true
end
