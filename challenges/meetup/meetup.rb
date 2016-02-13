require 'date'

class Meetup
  attr_reader :year, :month

  def initialize(month, year)
    @month = month
    @year = year
  end

  def day(weekday, schedule)
    case schedule
    when :teenth                 
      find_teenth_day(weekday)
    when :first
      find_first_day(weekday)
    when :second
      find_second_day(weekday)
    when :third
      find_third_day(weekday)
    when :fourth
      find_fourth_day(weekday)
    when :last
      find_last_day(weekday)
    end
  end

  def find_teenths
    teenths = []
    7.times { |num| teenths << Date.new(year, month, 13 + num) }
    teenths
  end

  def find_teenth_day(day) 
    teenth_dates = find_teenths
    teenth_dates.select! { |date| date.public_send((day.to_s + '?').to_sym) }
    teenth_dates[0]
  end

  def find_firsts
    firsts = []
    7.times { |num| firsts << Date.new(year, month, 1 + num) }
    firsts
  end

  def find_first_day(day)
    first_dates = find_firsts
    first_dates.select! {|date| date.public_send((day.to_s + '?').to_sym)}
    first_dates[0]
  end

  def find_second_day(day)
    second_dates = find_seconds
    second_dates.select! {|date| date.public_send((day.to_s + '?').to_sym)}
    second_dates[0]
  end

  def find_seconds
    seconds = []
    7.times { |num| seconds << Date.new(year, month, 8 + num)}
    seconds
  end

  def find_third_day(day)
    third_dates = find_thirds
    third_dates.select! {|date| date.public_send((day.to_s + '?').to_sym)}
    third_dates[0]
  end

  def find_thirds
    thirds = []
    7.times { |num| thirds << Date.new(year, month, 15 + num) }
    thirds
  end

  def find_fourth_day(day)
    fourth_dates = find_fourths
    fourth_dates.select! {|date| date.public_send((day.to_s + '?').to_sym)}
    fourth_dates[0]
  end

  def find_fourths
    fourths = []
    7.times { |num| fourths << Date.new(year, month, 22 + num) }
    fourths
  end

  def find_last_day(day)
    last_dates = find_lasts
    last_dates.select! {|date| date.public_send((day.to_s + '?').to_sym)}
    last_dates[0]
  end

  def find_lasts
    lasts = []
    last_day = Date.new(year, month, -1).day
    7.times { |num| lasts << Date.new(year, month, last_day - num) }
    lasts
  end
end



