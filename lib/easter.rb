class Date
  def self.easter(year, method)
    # Calculates the date of Easter for the given year using three
    # different methods:
    #
    # 1. Original Calculation (Julian Calendar):
    #    Valid for all years from 326 A.D.
    #
    # 2. Original Calculation (Gregorian Calendar):
    #    Valid for years 1583 A.D. to 4099 A.D.
    #
    # 3. Revised Calculation (Gregorian Calendar):
    #    Valid for years 1583 A.D. to 4099 A.D.
    #
    # For more information about the algorithm used here, see:
    # http://dates.gmarts.org/eastalg.htm
    # https://www.assa.org.au/edm#Method

    # Check for invalid arguments
    if !method.between?(1, 3)
      raise ArgumentError, "Invalid method number"
    elsif method == 1 && year < 326
      raise ArgumentError, "Method 1 only applies to years from 326"
    elsif (method == 2 || method == 3) && !year.between?(1583, 4099)
      raise ArgumentError, "Methods 2 and 3 only apply to years 1583 to 4099"
    end

    century = year / 100  # first two digits of year
    golden = year % 19    # calculate the Golden Number

    if method == 1 || method == 2
      # calculate Paschal full moon
      table_a = (225 - 11 * golden) % 30 + 21

      # find the next Sunday
      table_b = (table_a - 19) % 7
      table_c = (40 - century) % 7

      temp = year % 100
      table_d = (temp + temp / 4) % 7

      table_e = (20 - table_b - table_c - table_d) % 7 + 1
      day = table_a + table_e

      if method == 2
        # convert Julian date to Gregorian date
        temp = 10
        temp += century - 16 - ((century - 16) / 4) if year > 1600
        day += temp
      end
    elsif method == 3
      # calculate the Paschal full moon
      temp = (century - 15) / 2 + 202 - 11 * golden

      minus_centuries = [ 21, 24, 25, 27, 28, 29, 30, 31, 32, 34, 35, 38 ]
      plus_centuries = [ 33, 36, 37, 39, 40 ]

      case century
      when *minus_centuries then temp -= 1
      when *plus_centuries then temp += 1
      end

      temp %= 30
      table_a = temp + 21
      table_a -= 1 if temp == 29
      table_a -= 1 if temp == 28 && golden > 10

      # find the next Sunday
      table_b = (table_a - 19) % 7

      table_c = (40 - century) % 4
      table_c += 1 if table_c == 3
      table_c += 1 if table_c > 1

      temp = year % 100
      table_d = (temp + temp / 4) % 7

      table_e = (20 - table_b - table_c - table_d) % 7 + 1
      day = table_a + table_e
    end

    # return the date
    if day > 61
      day -= 61
      month = 5
    elsif day > 31
      day -= 31
      month = 4
    else
      month = 3
    end

    new(year, month, day)
  end
end
