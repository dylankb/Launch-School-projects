class Banner
  def initialize(message)
    @message = message
    measurement
  end

  def to_s
    [horizontal_rule, empty_line, message_line, empty_line, horizontal_rule].join("\n")
  end

  private

  def horizontal_rule
   "+-#{@dashes}-+" 
  end

  def empty_line
    "| #{@spaces} |"
  end

  def measurement
    @dashes = "-" * @message.length
    @spaces = " " * @message.length
  end

  def message_line
    "| #{@message} |"
  end
end

puts Banner.new("Hello Clarice")