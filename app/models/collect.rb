class Collect < ApplicationRecord
  belongs_to :day

  validates :text, presence: true
end
