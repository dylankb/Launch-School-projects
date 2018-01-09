class Student
  def initialize(name, year)
    @name = name
    @year = year
  end
end

class Graduate < Student
  attr_reader :name
  def initialize(name, year, parking)
    super(name, year)
    @parking = parking
  end

end

class Undergraduate < Student
  def initialize(name, year)
  end
end
