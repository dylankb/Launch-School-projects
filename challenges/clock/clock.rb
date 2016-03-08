class Clock
  attr_reader :hour, :minutes

  def initialize(hour, minutes=0)
    @hour = hour
    @minutes = minutes
  end

  def self.at(hour, minutes=0)
    Clock.new(hour, minutes)
  end

  def + (new_time)
    @hour += (new_time + @minutes) / 60
    @minutes = (@minutes + new_time) % 60

    Clock.new(@hour, @minutes)
  end

  def - (new_time)
    hours_to_subtract = (new_time - @minutes) / 60
    hours_to_subtract += 1 if (@minutes - new_time) < 0
    @hour -= hours_to_subtract

    @minutes = (@minutes - new_time) % 60 
    
    Clock.new(@hour, @minutes)
  end

  def to_s
    @hour >= 24 ? @hour -= 24: @hour
    @hour < 0 ? @hour += 24: @hour

    @hour.to_s.chars.size < 2 ? hour_str = "0#{@hour}": hour_str = @hour
    @minutes.to_s.chars.size < 2 ? minutes_str = "0#{@minutes}": minutes_str = @minutes
    "#{hour_str}:#{minutes_str}"
  end

  def ==(other_clock)
    hour == other_clock.hour && minutes == other_clock.minutes
  end
end
