class Psalm < ApplicationRecord
  has_many :verses

  validates :number, presence: true
  validates :title, presence: true

  def get_text(reference)
    psalm_text = "#{reference}\n\n"
    verses = get_verses_by_reference(reference)
    verses.each do |verse|
      psalm_text << "#{verse.number} #{verse.first_half} *\n\t#{verse.second_half}\n\n"
    end
    psalm_text
  end

  def get_html(reference)
    psalm_html = "<h2>#{reference}</h2>"
    verses = get_verses_by_reference(reference)
    verses.each do |verse|
      psalm_html << "<p><b>#{verse.number}</b> #{verse.first_half} *<br>&nbsp;&nbsp;#{verse.second_half}</p>"
    end
    psalm_html
  end

  private

  def get_verses_by_reference(reference)
    if reference.include?(":")
      verse_numbers = parse_verse_numbers(reference)
      verse_numbers.map { |number| verses.find_by(number: number) }
    else
      verses.all
    end
  end

  def parse_verse_numbers(reference)
    verse_numbers = []
    verse_references = reference.split(":")[1].split(/[\s,;()]/).reject { |s| s.empty? }
    verse_references.each do |reference|
      if reference.include?("-")
        start_num, end_num = reference.split("-")
        (start_num..end_num).each { |num| verse_numbers << num.to_i }
      else
        verse_numbers << reference.to_i
      end
    end
    verse_numbers
  end
end
