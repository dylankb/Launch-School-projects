class Garden

  PLANTS = { G: :grass, C: :clover, R: :radishes, V: :violets }
  STUDENTS = ["Alice", "Bob", "Charlie", "David", "Eve", "Fred", "Ginny", "Harriet", "Ileana", "Joseph", "Kincaid", "Larry"]

  def initialize(garden, students = STUDENTS)
    @rows = garden.split("\n")
    @students = students.sort

    @students.each do |student|
      define_singleton_method(student.downcase) {
        index = @students.index(student) * 2
        find_student_plants(index) }
    end
  end

  def find_student_plants(index)
    plant_initials = []
    @rows.each do |row|
      plant_initials << row[index..index+1]
    end
    translate_plant_names(plant_initials)
  end

  def translate_plant_names(rows)
    plant_letters = rows.join.split("")
    plant_letters.each_with_object([]) do |letter, plant_names|
      plant_names << PLANTS[letter.to_sym]
    end
  end
end
