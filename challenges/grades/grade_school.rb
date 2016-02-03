class School
  attr_reader :school

  def initialize
    @school = {}
  end

  def add(name, grade)
    new_student = {grade => [name]}
    school.merge!(new_student) {|key, oldval, newval| oldval << newval[0]}
  end

  def to_h
    school.values.map(&:sort!)
    school.sort.to_h
  end

  def grade(grade)
    school.fetch(grade, Array.new) 
  end
end

school = School.new
school.add('Aimee', 6)
school.add('Aimee', 2)
school.add('John', 2)
school.add('John', 3)
p school.to_h
