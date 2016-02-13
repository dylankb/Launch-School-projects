class School
  attr_reader :roster

  def initialize
    @roster = {}
  end

  def add(name, _grade)
    roster[_grade] = grade(_grade) << name
  end

  def to_h
    roster.values.map(&:sort!)
    roster.sort.to_h
  end

  def grade(_grade)
    roster.fetch(_grade, Array.new) 
  end
end