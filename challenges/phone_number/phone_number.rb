class PhoneNumber

  def initialize(number)
    @number_string = number
  end

  def number
    return '0000000000' unless @number_string.scan(/[a-z]/).size == 0
    numbers = @number_string.scan(/\d/).join
    numbers.slice!(0,1) if numbers[0] == '1' && numbers.size == 11
    return '0000000000' unless numbers.size == 10
    numbers    
  end

  def area_code
    self.number[0..2]
  end

  def to_s
    numbers = self.number.chars
    "(#{self.area_code}) #{numbers.slice(3..5).join}-#{numbers.slice(6..9).join}"
  end
end

