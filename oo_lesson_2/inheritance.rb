# 1 - 3.

class Animal

  def run
    'running!'
  end

  def jump
    'jumping!'
  end
end

class Dog < Animal

  def speak
    'bark!'
  end
  
  def swim
    'swimming!'
  end

  def fetch
    'fetching!'
  end
end

class Cat < Animal
  def speak
    'meow!'
  end
end

class Bulldog < Dog

  def swim
    'can\'t swim!'
  end
end

pete = Animal.new
kitty = Cat.new
dave = Dog.new
bud = Bulldog.new

puts Bulldog.ancestors

# pete.run                # => "running!"
# pete.speak              # => NoMethodError

# kitty.run               # => "running!"
# kitty.speak             # => "meow!"
# kitty.fetch             # => NoMethodError

# dave.speak              # => "bark!"

# bud.run                 # => "running!"
# bud.swim                # => "can't swim!"

#4. Method lookup path is the order in Ruby looks for methods to invoke.
#   It is extremely important because method lookup determines
#   whether a method overrides class Object methods (usually bad)
#   and how other methods are/are not accessible and overwrite one
#   another.