class PhoneNumber

  ERROR_NUMBER = '0000000000'

  def initialize(number)
    @number = number
    @number = has_alpha_characters? ? ERROR_NUMBER : number.scan(/\d/).join
  end

  def number
    @number.slice!(0,1) if @number[0] == '1' && @number.size == 11
    return ERROR_NUMBER unless @number.size == 10
    @number    
  end

  def has_alpha_characters?
    @number.scan(/[a-z]/).size != 0
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



