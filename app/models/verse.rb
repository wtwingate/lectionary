class Verse < ApplicationRecord
  belongs_to :psalm

  validates :number, presence: true
  validates :first_half, presence: true
  validates :second_half, presence: true
end
