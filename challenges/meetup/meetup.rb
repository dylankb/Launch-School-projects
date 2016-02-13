require 'date'

class Meetup
  attr_reader :year, :month

  START_DAY = { first: 1, second: 8, teenth: 13, third: 15, fourth: 22 }

  def initialize(month, year)
    @month = month
    @year = year
  end

  def day(weekday, schedule)
    find_weekday_in_month(weekday, schedule)
  end

  def find_date_range(schedule)
    if schedule == :last
      last_day = Date.new(year, month, -1).day
      7.times.inject([]) { |days, num| days << Date.new(year, month, last_day - num) }
    else
      7.times.inject([]) { |days, num| days << Date.new(year, month, START_DAY[schedule] + num) }
    end
  end

  def find_weekday_in_month(day, schedule)
    dates = find_date_range(schedule)
    dates.select! { |date| date.public_send((day.to_s + '?').to_sym) } #i.e date.monday?
    dates[0]
  end
end
