class Series

  def initialize(string)
    @string = string.split("")
  end

  def slices(num)
    raise ArgumentError if num > @string.size

    output = []
    @string.each_cons(num) { |set| output << set.map(&:to_i)}
    output
  end
end

p Series.new("01234").slices(1)
