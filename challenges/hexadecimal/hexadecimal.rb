class Hexadecimal

numeric = (10..16).to_a
alpha = ('a'...'f').to_a
ALPHANUMERIC = {}
alpha.each_with_index do | letter, index|
  ALPHANUMERIC[letter] = numeric[index]
end

  def initialize(string)
    @string = string
  end

# use hash to covert to_i. run on all elements
  def format_values
    @string.chars.map do |character|
      character =~ /\D/ ? ALPHANUMERIC[character.downcase] ? character.to_i
    end
  end

  def to_decimal
    format_values.reverse.map
  end
end

p Hexadecimal.new('1e42').convert_to_array_of_integers
