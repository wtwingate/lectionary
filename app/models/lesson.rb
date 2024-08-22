class Lesson < ApplicationRecord
  belongs_to :day

  validates :references, presence: true
end
