class Lesson < ApplicationRecord
  belongs_to :day
  has_many :passages

  validates :references, presence: true

  def print_references
    self.references.join(" or ")
  end
end
