require "test_helper"

class EasterTest < ActiveSupport::TestCase
  test "date of Easter from 2000 to 2099" do
    # Dates of Easter 2000 - 2099 from https://www.census.gov/data/software/x13as/genhol/easter-dates.html#par_textimage_1067001717
    easter_dates = [
      Date.new(2000, 4, 23), Date.new(2001, 4, 15), Date.new(2002, 3, 31), Date.new(2003, 4, 20), Date.new(2004, 4, 11), Date.new(2005, 3, 27), Date.new(2006, 4, 16), Date.new(2007, 4, 8), Date.new(2008, 3, 23), Date.new(2009, 4, 12),
      Date.new(2010, 4, 4), Date.new(2011, 4, 24), Date.new(2012, 4, 8), Date.new(2013, 3, 31), Date.new(2014, 4, 20), Date.new(2015, 4, 5), Date.new(2016, 3, 27), Date.new(2017, 4, 16), Date.new(2018, 4, 1), Date.new(2019, 4, 21),
      Date.new(2020, 4, 12), Date.new(2021, 4, 4), Date.new(2022, 4, 17), Date.new(2023, 4, 9), Date.new(2024, 3, 31), Date.new(2025, 4, 20), Date.new(2026, 4, 5), Date.new(2027, 3, 28), Date.new(2028, 4, 16), Date.new(2029, 4, 1),
      Date.new(2030, 4, 21), Date.new(2031, 4, 13), Date.new(2032, 3, 28), Date.new(2033, 4, 17), Date.new(2034, 4, 9), Date.new(2035, 3, 25), Date.new(2036, 4, 13), Date.new(2037, 4, 5), Date.new(2038, 4, 25), Date.new(2039, 4, 10),
      Date.new(2040, 4, 1), Date.new(2041, 4, 21), Date.new(2042, 4, 6), Date.new(2043, 3, 29), Date.new(2044, 4, 17), Date.new(2045, 4, 9), Date.new(2046, 3, 25), Date.new(2047, 4, 14), Date.new(2048, 4, 5), Date.new(2049, 4, 18),
      Date.new(2050, 4, 10), Date.new(2051, 4, 2), Date.new(2052, 4, 21), Date.new(2053, 4, 6), Date.new(2054, 3, 29), Date.new(2055, 4, 18), Date.new(2056, 4, 2), Date.new(2057, 4, 22), Date.new(2058, 4, 14), Date.new(2059, 3, 30),
      Date.new(2060, 4, 18), Date.new(2061, 4, 10), Date.new(2062, 3, 26), Date.new(2063, 4, 15), Date.new(2064, 4, 6), Date.new(2065, 3, 29), Date.new(2066, 4, 11), Date.new(2067, 4, 3), Date.new(2068, 4, 22), Date.new(2069, 4, 14),
      Date.new(2070, 3, 30), Date.new(2071, 4, 19), Date.new(2072, 4, 10), Date.new(2073, 3, 26), Date.new(2074, 4, 15), Date.new(2075, 4, 7), Date.new(2076, 4, 19), Date.new(2077, 4, 11), Date.new(2078, 4, 3), Date.new(2079, 4, 23),
      Date.new(2080, 4, 7), Date.new(2081, 3, 30), Date.new(2082, 4, 19), Date.new(2083, 4, 4), Date.new(2084, 3, 26), Date.new(2085, 4, 15), Date.new(2086, 3, 31), Date.new(2087, 4, 20), Date.new(2088, 4, 11), Date.new(2089, 4, 3),
      Date.new(2090, 4, 16), Date.new(2091, 4, 8), Date.new(2092, 3, 30), Date.new(2093, 4, 12), Date.new(2094, 4, 4), Date.new(2095, 4, 24), Date.new(2096, 4, 15), Date.new(2097, 3, 31), Date.new(2098, 4, 20), Date.new(2099, 4, 12)
    ]

    easter_dates.each do |date|
      assert_equal(date, Easter.easter(date.year, 3))
    end
  end
end
