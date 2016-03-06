class Klass
  def self.+(a,b)
    a + b
  end

  def to_s
    "kangaroos!"
  end
end

puts Klass.+(5,5)

class Dog
  def initialize(name)
    @name = name
  end

  def to_s
    "My name is #{@name} the dog."
  end
end

puts Dog.new('Frank')

