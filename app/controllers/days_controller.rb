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
    @passages_text = ""
    @passages_html = ""

    @day.lessons.each do |lesson|
      lesson.references.each do |reference|
        passage = lesson.passages.find_or_create_by(
          reference: reference
        )
        @passages_text << passage[:esv_text]
        @passages_html << passage[:esv_html]
      end
    end
  end
end
