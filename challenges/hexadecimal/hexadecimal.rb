class Hexadecimal

numeric = (10..15).to_a
alpha = ('a'...'g').to_a
ALPHANUMERIC = {}
alpha.each_with_index do | letter, index|
  ALPHANUMERIC[letter] = numeric[index]
end

  def initialize(string)
    @string = string
  end

  def format_values
    @string.chars.map do |character|
      character =~ /\D/ ? ALPHANUMERIC[character.downcase] : character.to_i
    end
  end

  def to_decimal
    format_values.reverse.map.with_index do |value, index|
      value * (16 ** index)
    end.inject(:+)
  end
end

#p Hexadecimal.new('1e42').to_decimal

