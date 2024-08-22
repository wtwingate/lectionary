class Lesson < ApplicationRecord
  belongs_to :day

  validates :references, presence: true

  def print_references
    self.references.join(" or ")
  end
end
