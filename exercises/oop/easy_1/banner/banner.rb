class Banner
  def initialize(message, width)
    @message = message
    @width = width
    calculate_padding
    raise "Uneven width" unless @width.even?
  end

  def to_s
    [horizontal_rule, empty_line, message_line, empty_line, horizontal_rule].join("\n")
  end

  private

  def calculate_padding
    if @width - @message.length < 2
      @padding = 2
    else
      @padding = @width - @message.length
    end
  end

  def horizontal_rule
   "+-#{"-" * (@message.length + @padding)}-+" 
  end

  def empty_line
    "| #{' ' * (@message.length + @padding)} |"
  end

  def message_line
    "|#{' ' * (@padding/2)} #{@message} #{' ' * (@padding/2)}|"
  end
end

puts Banner.new("To boldly go where no one has gone before.", 112)