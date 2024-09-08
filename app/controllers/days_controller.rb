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

    @results = {}
    calendars.each do |calendar|
      next if calendar.days.empty?

      calendar.days.each do |name|
        days = Day.where(name: name, year: calendar.year)
        days.each do |day|
          day[:season] = calendar.season if day[:season].nil?
        end
        @results[calendar.date] = days
      end
    end
  end

  def show
    @day = Day.find(params[:id])
    @lessons_html = []
    @lessons_text = []

    @lessons_text << "Collect of the Day"
    @lessons_text << @day.collects.first.text

    @day.lessons.each do |lesson|
      lesson.passages.each { |passage| passage.fetch_missing_data }

      @lessons_html << lesson.passages.first.get_html

      @lessons_text << lesson.passages.first.reference
      @lessons_text << lesson.passages.first.get_text
    end
  end
end
