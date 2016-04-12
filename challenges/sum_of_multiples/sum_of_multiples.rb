require 'pry'

class SumOfMultiples

  def self.to(limit)
    (0..limit - 1).select {|number| number % 3 == 0 || number % 5 == 0}.reduce(&:+)
  end

  def initialize(*multiples)
    @multiples = multiples
  end

  def find_multiples_in(range)
    results = []
    @multiples.each do |multiple|
      range.each do |number|
        results << number if number % multiple == 0
      end
    end
    results
  end

  def to(limit)
    range = ((0..limit).to_a)[0..-2]
    multiples = find_multiples_in(range)
    multiples.uniq.inject(:+)
  end
end

p SumOfMultiples.to(20)