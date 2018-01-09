ROMAN_NUMERALS = {
  'I' => 1,
  'V' => 5,
  'X' => 10,
  'L' => 50,
  'C' => 100,
  'D' => 500,
  'M' => 1_000
}

def to_arabic_numbers(roman_numeral)
  roman_numeral_chars = roman_numeral.chars
  return false unless valid_input(roman_numeral_chars)

  total = 0
  skip_next_iteration = false
  roman_numeral_chars_reversed = roman_numeral_chars.reverse
  roman_numeral_chars_reversed.each_with_index do |character, index|
    roman_numeral_value = ROMAN_NUMERALS[character]
    next_roman_numeral_char = ROMAN_NUMERALS[roman_numeral_chars_reversed[index + 1]]

    if skip_next_iteration
      skip_next_iteration = false
      next
    elsif next_roman_numeral_char.nil? || roman_numeral_value <= next_roman_numeral_char
      total += roman_numeral_value
      break if next_roman_numeral_char.nil?
    else
      total += roman_numeral_value - next_roman_numeral_char
      skip_next_iteration = true
    end
  end

  total
end

def valid_input(roman_numeral_chars)
  roman_numeral_chars.all? do |character|
    ROMAN_NUMERALS.keys.include?(character)
  end
end

puts to_arabic_numbers('XX')  # 20
puts to_arabic_numbers('XIV') # 14
puts to_arabic_numbers('IVX') # 6 - is this a valid Roman numeral?
puts to_arabic_numbers('XVI') # 16
