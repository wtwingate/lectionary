class DaysController < ApplicationController
  def index
    start_date = Date.today()
    unless params[:start_date].nil? || params[:start_date].empty?
      start_date = Date.parse(params[:start_date])
    end

    end_date = start_date + 4.weeks
    unless params[:end_date].nil? || params[:end_date].empty?
      end_date = Date.parse(params[:end_date])
    end

    dates = (start_date..end_date).to_a
    calendars = dates.map { |date| Calendar.new(date) }

    days = []
    calendars.each do |calendar|
      next if calendar.days.empty?

      calendar.days.each do |name|
        matches = Day.where(name: name, year: calendar.year)
        matches.each do |match|
          match[:season] = calendar.season if match[:season].nil?
        end
        days += matches
      end
    end

    @days = days
  end

  def show
    @day = Day.find(params[:id])

    passages = @day.lessons.map do |lesson|
      lesson.references.map do |reference|
        Esv.new(reference, "html").fetch_passages
      end
    end

    @passages = passages.flatten
  end
end
