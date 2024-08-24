class Verse < ApplicationRecord
  belongs_to :psalm

  validates :number, presence: true
  validates :first_half, presence: true
  validates :second_half, presence: true

  def format_html
    "<p><b>#{number}</b> #{first_half} *<br>&nbsp;&nbsp;#{second_half}</p>"
  end
end
