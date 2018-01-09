# class Person
#   attr_accessor :first_name, :last_name

#   def initialize(n, l='')
#     @name = n
#     @first_name = n
#     @last_name = l
#   end

#   def name
#     @first_name +' ' + @last_name
#   end

# end

# bob = Person.new('Robert')
# puts bob.name
# bob.first_name
# bob.last_name = 'Smith'
# puts bob.name

# 3.

# class Person
#   attr_accessor :first_name, :last_name

#   def initialize(name)
#     parts = name.split
#     @first_name = parts.first
#     @last_name = parts.size > 1 ? parts.last : ''
#   end

#   def name
#     "#{first_name} #{last_name}".strip
#   end

#   def name=(full_name)
#     parts = full_name.split
#     self.first_name = parts.first
#     self.last_name = parts.size > 1 ? parts.last : ''
#   end

# end

# 3b. 

class Person
  attr_accessor :first_name, :last_name

  def initialize(full_name)
    parse_full_name(full_name)
  end

  def name
    "#{first_name} #{last_name}".strip
  end

  def name=(full_name)
    parse_full_name(full_name)
  end

  def to_s
    name
  end

  private

  def parse_full_name(full_name)
    parts = full_name.split
    self.first_name = parts.first
    self.last_name =  parts.size > 1 ? parts.last : ''
  end
end

bob = Person.new('Robert Smith')
rob = Person.new('Robert Smith')
puts bob.name == rob.name

puts bob

