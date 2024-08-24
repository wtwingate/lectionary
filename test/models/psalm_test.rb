require "test_helper"

class PsalmTest < ActiveSupport::TestCase
  test "fixtures work" do
    assert_equal(2, Psalm.all.count)
  end

  test "parse single verse number" do
    psalm = Psalm.all.first
    assert_equal([ 1 ], psalm.send(:parse_verse_numbers, "Psalm 1:1"))
  end

  test "parse multiple verse numbers" do
    psalm = Psalm.all.first
    assert_equal([ 1, 2, 3 ], psalm.send(:parse_verse_numbers, "Psalm 1:1-3"))
  end

  test "parse multiple + single verse numbers" do
    psalm = Psalm.all.first
    assert_equal([ 1, 2, 3, 4 ], psalm.send(:parse_verse_numbers, "Psalm 1:1-3, 4"))
  end

  test "parse optional verse numbers" do
    psalm = Psalm.all.first
    assert_equal([ 1, 2, 3, 4 ], psalm.send(:parse_verse_numbers, "Psalm 1:1, (2-4)"))
  end

  test "parse complicated verse numbers" do
    psalm = Psalm.all.first
    assert_equal([ 1, 2, 3, 4, 5, 6, 7 ], psalm.send(:parse_verse_numbers, "Psalm 1:1-3, 4; (5-6), 7"))
  end
end
