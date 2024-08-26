class Lesson < ApplicationRecord
  belongs_to :day
  has_many :passages

  validates :references, presence: true
end
