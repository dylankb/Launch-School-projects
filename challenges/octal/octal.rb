class Octal
  def initialize(number)
    @number = number
  end

  def is_number?
    return 0 unless @number.is_a?(String)
  end

  def transform
    is_number?
    result = 0
    number_arr = @number.split('').reverse!
    number_arr.each_with_index do |num, idx| 
      result += num.to_i * 8 ** idx
    end
    result
  end
end

oct = Octal.new('10')
puts oct.transform



