class Vehicle
  def initialize(make, model)
    @make = make
    @model = model
  end

  def to_s
    "#{make} #{model}"
  end

  def wheels(count)
    count
  end
end

class Car < Vehicle
  attr_reader :make, :model

  def initialize(make, model)
    super
  end

  def wheels
    super(4)
  end
end

class Motorcycle < Vehicle
  attr_reader :make, :model

  def initialize(make, model)
    super
  end

  def wheels
    super(2)
  end
end

class Truck < Vehicle
  attr_reader :make, :model, :payload

  def initialize(make, model, payload)
    super(make, model)
    @payload = payload
  end

  def wheels
    super(6)
  end
end


t = Truck.new('Ford', 'Ranger', 2000)
puts t
puts t.make
puts t.model
puts t.wheels
