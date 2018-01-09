class Pet
  attr_reader :name

  def initialize(name)
    @name = name.to_s
  end

  def to_s
    @name.upcase!
    "My name is #{@name}."
  end
end

name = 'Fluffy'
fluffy = Pet.new(name)
puts fluffy.name # Fluffy
puts fluffy # FLUFFY
puts fluffy.name # FLUFFY
puts name # FLUFFY - name and @name reference same object in memory

class Pet
  attr_reader :name

  def initialize(name)
    @name = name.to_s
  end

  def to_s
    "My name is #{@name.upcase}."
  end
end

name = 'Fluffy'
fluffy = Pet.new(name)
puts fluffy.name  # Fluffy
puts fluffy       # Fluffy
puts fluffy.name  # Fluffy
puts name         # Fluffy

name = 42
fluffy = Pet.new(name)
name += 1 # 43 - creates a new reference, so @name value does not change.
puts fluffy.name # 42
puts fluffy # 42
puts fluffy.name # 42
puts name # 43
