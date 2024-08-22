require "test_helper"

require "csv"
require "date"

class CalendarTest < ActiveSupport::TestCase
  test "moveable dates" do
    (2000..2100).each do |year|
      calendar = Calendar.new(Date.new(year, 1, 1))

      moveable_dates = []
      CSV.table("test/lib/moveable_dates.csv").each do |row|
        moveable_dates.append({
          easter: Date.parse("#{year}-#{row[:easter]}"),
          ash: Date.parse("#{year}-#{row[:ash]}"),
          ascension: Date.parse("#{year}-#{row[:ascension]}"),
          pentecost: Date.parse("#{year}-#{row[:pentecost]}"),
          advent: Date.parse("#{year}-#{row[:advent]}")
        })
      end

      test_case = moveable_dates.find { |md| md[:easter] == calendar.moveable[:easter] }

      # In leap years, Ash Wednesday falls one day later in February
      if calendar.date.leap? && test_case[:ash].month == 2
        test_case[:ash] += 1.day
      end

      calendar.moveable.each do |key, val|
        assert_equal(test_case[key], val)
      end
    end
  end

  test "liturgical year" do
    expected = [
      { date: Date.new(2019, 12, 31), year: "A" },
      { date: Date.new(2020, 12, 31), year: "B" },
      { date: Date.new(2021, 12, 31), year: "C" },
      { date: Date.new(2019, 1, 1), year: "C" },
      { date: Date.new(2020, 1, 1), year: "A" },
      { date: Date.new(2021, 1, 1), year: "B" }
    ]

    expected.each do |e|
      calendar = Calendar.new(e[:date])
      assert_equal(e[:year], calendar.year)
    end
  end

  test "liturgical season" do
    expected = [
      { date: Date.new(2019, 1, 5), season: "Christmas" },
      { date: Date.new(2019, 1, 6), season: "Epiphany" },
      { date: Date.new(2019, 3, 5), season: "Epiphany" },
      { date: Date.new(2019, 3, 6), season: "Lent" },
      { date: Date.new(2019, 4, 20), season: "Lent" },
      { date: Date.new(2019, 4, 21), season: "Easter" },
      { date: Date.new(2019, 6, 8), season: "Easter" },
      { date: Date.new(2019, 6, 9), season: "Pentecost" },
      { date: Date.new(2019, 11, 30), season: "Pentecost" },
      { date: Date.new(2019, 12, 1), season: "Advent" },
      { date: Date.new(2019, 12, 24), season: "Advent" },
      { date: Date.new(2019, 12, 25), season: "Christmas" }
    ]

    expected.each do |e|
      calendar = Calendar.new(e[:date])
      assert_equal(e[:season], calendar.season)
    end
  end
end
