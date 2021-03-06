class Trinary

  def initialize(string)
    @string = string
  end

  def valid_number?
    return true unless @string =~ /[^012]/
  end

  def format_number
    @string.chars.reverse.map(&:to_i)
  end

  def to_decimal
    return 0 unless valid_number?
    format_number.map.with_index { |num, index| num * (3 ** index) }.inject(:+)
  end
end

puts Trinary.new("0123").to_decimal