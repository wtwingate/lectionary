require "date"

class Calendar
  attr_reader :date, :easter, :moveable, :fixed, :year, :season, :days

  def initialize(date)
    @date = date
    @fixed = self.calc_fixed
    @moveable = self.calc_moveable
    @year = self.calc_year
    @season = self.calc_season
    @days = self.calc_days
  end

  private

  def calc_fixed
    {
      new_year: Date.new(@date.year, 1, 1),
      epiphany: Date.new(@date.year, 1, 6),
      all_saints: Date.new(@date.year, 11, 1),
      christmas: Date.new(@date.year, 12, 25)
    }
  end

  def calc_moveable
    easter = Date.easter(@date.year, 3)
    advent = @fixed[:christmas].prev_occurring(:sunday) - 3.weeks

    {
      easter: easter,
      ash: easter - 46.days,
      ascension: easter + 39.days,
      pentecost: easter + 49.days,
      advent: advent
    }
  end

  def calc_year
    year = @date.year
    year -= 1 if @date < @moveable[:advent]

    case year % 3
    when 0 then "A"
    when 1 then "B"
    when 2 then "C"
    end
  end

  def calc_season
    if @date.between?(@fixed[:new_year], @fixed[:epiphany] - 1.day)
      "Christmas"
    elsif @date.between?(@fixed[:epiphany], @moveable[:ash] - 1.day)
      "Epiphany"
    elsif @date.between?(@moveable[:ash], @moveable[:easter] - 1.day)
      "Lent"
    elsif @date.between?(@moveable[:easter], @moveable[:pentecost] - 1.day)
      "Easter"
    elsif @date.between?(@moveable[:pentecost], @moveable[:advent] - 1.day)
      "Pentecost"
    elsif @date.between?(@moveable[:advent], @fixed[:christmas] - 1.day)
      "Advent"
    else
      "Christmas"
    end
  end

  def calc_days
    days = []
    days << self.principals
    days << self.holy_week
    days << self.easter_week
    days << self.sundays if @date.sunday?
    days << self.red_letters
    days << self.black_letters
    days.compact
  end

  def principals
    case @date
    when @fixed[:christmas] - 1.day then "Christmas Eve"
    when @fixed[:christmas] then "Christmas Day"
    when @fixed[:epiphany] then "The Epiphany"
    when @moveable[:ash] then "Ash Wednesday"
    when @moveable[:easter] - 1.day then "Easter Eve"
    when @moveable[:easter] then "Easter Day"
    when @moveable[:ascension] then "Ascension Day"
    when @moveable[:pentecost] then "Day of Pentecost"
    when @moveable[:pentecost] + 1.week then "Trinity Sunday"
    when @fixed[:all_saints] then "All Saints' Day"
    end
  end

  def holy_week
    case @date
    when @moveable[:easter] - 7.days then "Palm Sunday"
    when @moveable[:easter] - 6.days then "Monday in Holy Week"
    when @moveable[:easter] - 5.days then "Tuesday in Holy Week"
    when @moveable[:easter] - 4.days then "Wednesday in Holy Week"
    when @moveable[:easter] - 3.days then "Maundy Thursday"
    when @moveable[:easter] - 2.days then "Good Friday"
    when @moveable[:easter] - 1.day then "Holy Saturday"
    end
  end

  def easter_week
    case @date
    when @moveable[:easter] + 1.day then "Monday in Easter Week"
    when @moveable[:easter] + 2.days then "Tuesday in Easter Week"
    when @moveable[:easter] + 3.days then "Wednesday in Easter Week"
    when @moveable[:easter] + 4.days then "Thursday in Easter Week"
    when @moveable[:easter] + 5.days then "Friday in Easter Week"
    when @moveable[:easter] + 6.days then "Saturday in Easter Week"
    end
  end

  def sundays
    case @season
    when "Advent" then self.advent_sundays
    when "Christmas" then self.christmas_sundays
    when "Epiphany" then self.epiphany_sundays
    when "Lent" then self.lent_sundays
    when "Easter" then self.easter_sundays
    when "Pentecost" then self.pentecost_sundays
    end
  end

  def advent_sundays
    case @date
    when @moveable[:advent] then "First Sunday of Advent"
    when @moveable[:advent] + 1.week then "Second Sunday of Advent"
    when @moveable[:advent] + 2.weeks then "Third Sunday of Advent"
    when @moveable[:advent] + 3.weeks then "Fourth Sunday of Advent"
    end
  end

  def christmas_sundays
    if @date.between?(@fixed[:christmas] + 1.day, @fixed[:christmas] + 7.days)
      "First Sunday after Christmas"
    else
      "Second Sunday after Christmas"
    end
  end

  def epiphany_sundays
    first_sunday = @fixed[:epiphany].next_occurring(:sunday)

    case @date
    # check for last two Sundays of Epiphany first
    when @moveable[:easter] - 56.days then "Second to Last Sunday after Epiphany"
    when @moveable[:easter] - 49.days then "Last Sunday after Epiphany"
    # then check from the beginning
    when first_sunday then "First Sunday after Epiphany"
    when first_sunday + 1.week then "Second Sunday after Epiphany"
    when first_sunday + 2.weeks then "Third Sunday after Epiphany"
    when first_sunday + 3.weeks then "Fourth Sunday after Epiphany"
    when first_sunday + 4.weeks then "Fifth Sunday after Epiphany"
    when first_sunday + 5.weeks then "Sixth Sunday after Epiphany"
    when first_sunday + 6.weeks then "Seventh Sunday after Epiphany"
    when first_sunday + 7.weeks then "Eighth Sunday after Epiphany"
    end
  end

  def lent_sundays
    case @date
    when @moveable[:easter] - 6.weeks then "First Sunday in Lent"
    when @moveable[:easter] - 5.weeks then "Second Sunday in Lent"
    when @moveable[:easter] - 4.weeks then "Third Sunday in Lent"
    when @moveable[:easter] - 3.weeks then "Fourth Sunday in Lent"
    when @moveable[:easter] - 2.weeks then "Fifth Sunday in Lent"
    end
  end

  def easter_sundays
    case @date
    when @moveable[:easter] + 1.week then "Second Sunday of Easter"
    when @moveable[:easter] + 2.weeks then "Third Sunday of Easter"
    when @moveable[:easter] + 3.weeks then "Fourth Sunday of Easter"
    when @moveable[:easter] + 4.weeks then "Fifth Sunday of Easter"
    when @moveable[:easter] + 5.weeks then "Sixth Sunday of Easter"
    when @moveable[:easter] + 6.weeks then "Sunday after Ascension Day"
    end
  end

  def pentecost_sundays
    case @date
    when @moveable[:advent] - 29.weeks then "Proper 1"
    when @moveable[:advent] - 28.weeks then "Proper 2"
    when @moveable[:advent] - 27.weeks then "Proper 3"
    when @moveable[:advent] - 26.weeks then "Proper 4"
    when @moveable[:advent] - 25.weeks then "Proper 5"
    when @moveable[:advent] - 24.weeks then "Proper 6"
    when @moveable[:advent] - 23.weeks then "Proper 7"
    when @moveable[:advent] - 22.weeks then "Proper 8"
    when @moveable[:advent] - 21.weeks then "Proper 9"
    when @moveable[:advent] - 20.weeks then "Proper 10"
    when @moveable[:advent] - 19.weeks then "Proper 11"
    when @moveable[:advent] - 18.weeks then "Proper 12"
    when @moveable[:advent] - 17.weeks then "Proper 13"
    when @moveable[:advent] - 16.weeks then "Proper 14"
    when @moveable[:advent] - 15.weeks then "Proper 15"
    when @moveable[:advent] - 14.weeks then "Proper 16"
    when @moveable[:advent] - 13.weeks then "Proper 17"
    when @moveable[:advent] - 12.weeks then "Proper 18"
    when @moveable[:advent] - 11.weeks then "Proper 19"
    when @moveable[:advent] - 10.weeks then "Proper 20"
    when @moveable[:advent] - 9.weeks then "Proper 21"
    when @moveable[:advent] - 8.weeks then "Proper 22"
    when @moveable[:advent] - 7.weeks then "Proper 23"
    when @moveable[:advent] - 6.weeks then "Proper 24"
    when @moveable[:advent] - 5.weeks then "Proper 25"
    when @moveable[:advent] - 4.weeks then "Proper 26"
    when @moveable[:advent] - 3.weeks then "Proper 27"
    when @moveable[:advent] - 2.weeks then "Proper 28"
    when @moveable[:advent] - 1.week then "Proper 29"
    end
  end

  def red_letters
    case @date
    when Date.new(@date.year, 11, 30) then "Saint Andrew"
    when Date.new(@date.year, 12, 21) then "Saint Thomas"
    when Date.new(@date.year, 12, 26) then "Saint Stephen"
    when Date.new(@date.year, 12, 27) then "Saint John"
    when Date.new(@date.year, 12, 28) then "Holy Innocents"
    when Date.new(@date.year, 1, 1) then "Holy Name"
    when Date.new(@date.year, 1, 18) then "Confession of Saint Peter"
    when Date.new(@date.year, 1, 25) then "Conversion of Saint Paul"
    when Date.new(@date.year, 2, 2) then "The Presentation"
    when Date.new(@date.year, 2, 24) then "Saint Matthias"
    when Date.new(@date.year, 3, 19) then "Saint Joseph"
    when Date.new(@date.year, 3, 25) then "The Annunciation"
    when Date.new(@date.year, 4, 25) then "Saint Mark"
    when Date.new(@date.year, 5, 1) then "Saint Philip and Saint James"
    when Date.new(@date.year, 5, 31) then "The Visitation"
    when Date.new(@date.year, 6, 11) then "Saint Barnabas"
    when Date.new(@date.year, 6, 24) then "Nativity of Saint John the Baptist"
    when Date.new(@date.year, 6, 29) then "Saint Peter and Saint Paul"
    when Date.new(@date.year, 7, 22) then "Saint Mary Magdalene"
    when Date.new(@date.year, 7, 25) then "Saint James"
    when Date.new(@date.year, 8, 6) then "The Transfiguration"
    when Date.new(@date.year, 8, 15) then "Saint Mary the Virgin"
    when Date.new(@date.year, 8, 24) then "Saint Bartholomew"
    when Date.new(@date.year, 9, 14) then "Holy Cross Day"
    when Date.new(@date.year, 9, 21) then "Saint Matthew"
    when Date.new(@date.year, 9, 29) then "Saint Michael and All Angels"
    when Date.new(@date.year, 10, 18) then "Saint Luke"
    when Date.new(@date.year, 10, 23) then "Saint James of Jerusalem"
    when Date.new(@date.year, 10, 28) then "Saint Simon and Saint Jude"
    end
  end

  def black_letters
  end
end
