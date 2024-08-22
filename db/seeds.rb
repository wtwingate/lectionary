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

  data["lessons"].each do |lesson|
    day.lessons.find_or_create_by!(
      references: lesson
    )
  end
end
