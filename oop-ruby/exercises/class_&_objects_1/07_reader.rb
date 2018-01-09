class Cat
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def greet
    puts "My name is #{name}!"
  end
end

p Cat.new("Sophie").greet
