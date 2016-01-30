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
    output = []
    school.each do |grade|
      output << grade
      yield(grade) if block_given?
    end
  end

  def grade(grade)
    school.fetch(grade, Array.new) 
  end
end
