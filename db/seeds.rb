# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require "json"

# Seed Lectionary data

lectionary_file = File.open("db/lectionary.json").read
lectionary_data = JSON.parse(lectionary_file)

lectionary_data.each do |data|
  day = Day.find_or_create_by!(
    name: data["name"],
    service: data["service"],
    year: data["year"],
    season: data["seasons"],
    color: data["color"],
    rank: data["rank"]
  )

  data["collects"].each do |collect|
    day.collects.find_or_create_by!(
      text: collect
    )
  end

  data["lessons"].each do |references|
    lesson = day.lessons.find_or_create_by!(
      references: references.join(" or ")
    )

    references.each do |reference|
      lesson.passages.find_or_create_by!(
        reference: reference
      )
    end
  end
end

# Seed Psalter data

psalter_file = File.open("db/psalter.json").read
psalter_data = JSON.parse(psalter_file)

psalter_data.each do |data|
  psalm = Psalm.find_or_create_by!(
    number: data["number"],
    title: data["title"]
  )

  data["verses"].each do |verse|
    psalm.verses.find_or_create_by!(
      number: verse["number"],
      first_half: verse["firstHalf"],
      second_half: verse["secondHalf"]
    )
  end
end
