class SumOfMultiples

  def initialize(*factors)
    @factors = factors
  end

  def self.to(limit)
    new(3,5).to(limit)
  end

  def find_multiples_in(range)
    range.select do |number|
      @factors.any? { |factor| number % factor == 0 }
    end
  end

  def to(limit)
    range = (0..limit - 1)
    multiples = find_multiples_in(range)
    multiples.uniq.inject(:+)
  end
end

p SumOfMultiples.to(20)