class Day < ApplicationRecord
  VALID_YEARS = [ "A", "B", "C" ]
  VALID_SEASONS = [ "Advent", "Christmas", "Epiphany", "Lent", "Easter", "Pentecost" ]
  VALID_COLORS = [ "violet", "white", "green", "red", "blue", "rose" ]

  validates :name, presence: true
  validates :year, inclusion: { in: VALID_YEARS }
  validates :season, inclusion: { in: VALID_SEASONS }, allow_nil: true
  validates :color, inclusion: { in: VALID_COLORS }
  validates :rank, presence: true
end
