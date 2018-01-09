class Banner
  def initialize(message)
    @message = message
  end

  def to_s
    [horizontal_rule, empty_line, message_line, empty_line, horizontal_rule].join("\n")
  end

  private

  def horizontal_rule
    dashes = "-" * (@message.size)
    "+-#{dashes}-+"
  end

  def empty_line
    empty_space = " " * @message.size
    "| #{empty_space} |"

  end

  def message_line
    "| #{@message} |"
  end
end

banner = Banner.new('To boldly go where no one has gone before.')
puts banner
empty_banner = Banner.new('')
puts empty_banner
