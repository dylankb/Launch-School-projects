class Pet
  attr_reader :name, :type
  def initialize(type, name, shelter)
    @type = type
    @name = name
    add_to_shelter(shelter)
  end

  def add_to_shelter(shelter)
    shelter.add_to_shelter(self)
  end
end

class Owner
  attr_accessor :pets
  attr_reader :name

  def initialize(name)
    @name = name
    @pets = []
  end

  def add_pet(pet)
    @pets << pet
  end

  def number_of_pets
    @pets.size
  end

  def print_pets
    @pets.each do |pet|
      puts "a #{pet.type} called #{pet.name}"
    end
  end

end

class Shelter
  def initialize
    @adoptions = {}
    @to_adopt = {}
  end

  def adopt(owner, pet)
    owner.add_pet(pet)
    @adoptions[owner.name] ||= owner
    @to_adopt[pet] = false
  end

  def add_to_shelter(pet)
    @to_adopt[pet] = true
  end

  def print_adoptions
    @adoptions.each do |name, owner|
      puts "#{name} has adopted the following pets"
      owner.print_pets
      puts ""
    end
  end

  def print_available_pets
    puts "Here are the available pets"
    @to_adopt.each do |pet, available|
      if available
        puts "a #{pet.type} called #{pet.name}"
      end
    end
  end
end

phanson = Owner.new('P Hanson')
bholmes = Owner.new('B Holmes')

shelter = Shelter.new
butterscotch = Pet.new('cat', 'Butterscotch', shelter)
pudding      = Pet.new('cat', 'Pudding', shelter)
darwin       = Pet.new('bearded dragon', 'Darwin', shelter)
kennedy      = Pet.new('dog', 'Kennedy', shelter)
sweetie      = Pet.new('parakeet', 'Sweetie Pie', shelter)
molly        = Pet.new('dog', 'Molly', shelter)
chester      = Pet.new('fish', 'Chester', shelter)
shelter.adopt(phanson, butterscotch)
shelter.adopt(phanson, pudding)
shelter.adopt(phanson, darwin)
shelter.adopt(bholmes, kennedy)
shelter.adopt(bholmes, sweetie)
shelter.adopt(bholmes, molly)
shelter.adopt(bholmes, chester)
shelter.print_adoptions
puts "#{phanson.name} has #{phanson.number_of_pets} adopted pets."
puts "#{bholmes.name} has #{bholmes.number_of_pets} adopted pets."

Pet.new('dog', 'Asta', shelter)

shelter.print_available_pets
