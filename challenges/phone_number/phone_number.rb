class PhoneNumber

  def initialize(number)
    @number_string = number
  end

  def number
    return '0000000000' if has_alphabetic_characters?
    numbers = @number_string.scan(/\d/).join
    numbers.slice!(0,1) if numbers[0] == '1' && numbers.size == 11
    return '0000000000' unless numbers.size == 10
    numbers    
  end

  def has_alphabetic_characters?
    @number_string.scan(/[a-z]/).size != 0
  end

  def area_code
    number[0..2]
  end

  def central_office_code
    number.chars.slice(3..5).join
  end

  def line_code
    number.chars.slice(6..9).join
  end

  def to_s
    "(#{area_code}) #{central_office_code}-#{line_code}"
  end
end

puts PhoneNumber.new('9876543210').to_s



