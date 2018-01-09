class Pet
  def initialize(name, age)
    @name = name
    @age = age
  end
end

class Cat < Pet
  attr_reader :name, :age, :fur_type

  def initialize(name, age, fur_type)
    super(name, age)
    @fur_type = fur_type
  end

  def to_s
    "My #{name} is 7 #{age} and has #{fur_type} fur."
  end

end

pudding = Cat.new('Pudding', 7, 'black and white')
butterscotch = Cat.new('Butterscotch', 10, 'tan and white')
puts pudding, butterscotch

# My cat Pudding is 7 years old and has black and white fur.
# My cat Butterscotch is 10 years old and has tan and white fur.
