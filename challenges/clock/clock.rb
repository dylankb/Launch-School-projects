require 'pry'

# class Time
#   def to_s
#     self.strftime("%M:%S")
#   end
# end



#   def self.at(hour=0, minute=0)
#     Time.new(2000, 01, 1, 0, hour, minute)
#   end
# end

# clock = Clock.at(10) + 3
# puts clock

  # def self.at(hour=0, minute=0)
  #   Clock.new(hour)
  #   @hour_str = hour.to_s.length < 2 ? "0#{hour}" : hour.to_s
  #   @minute_str = minute.to_s.length < 2 ? "0#{minute}" : minute.to_s
    #{}"#{@hour_str}:#{@minute_str}"
  # end
class Clock

  def initialize(hour=0, minute=0)
    @hour = hour
    @minute = minute
  end

  def self.at(hour, minute=0)
    Clock.new(hour, minute)
  end

  def to_s
    format_number(@hour) + ':' + format_number(@minute)
  end

  def +(minutes)
    #Clock.new(@hour, @minute + minutes)
    @hour +=
    @minute + minutes
    self # the receiver of the + method
  end

  private

  def format_number(number)
    number.to_s.length < 2 ? "0#{number}" : number.to_s
  end
end