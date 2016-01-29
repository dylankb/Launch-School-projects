class Octal
  def initialize(number)
    @number = number
  end

  def to_decimal
    return 0 unless /^\d[^8|9]+$/ =~ @number
    @number.split('').reverse!.each_with_index.inject(0) do | sum, (num, idx)|
      sum += num.to_i * 8 ** idx
    end
  end
end


