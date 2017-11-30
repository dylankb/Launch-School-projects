class InvalidCoordinatesError < StandardError
end

class Location
  attr_reader :longitude, :latitude

  def initialize(latitude, longitude)
    raise InvalidCoordinatesError unless valid_coordinates?(latitude, longitude)
    @latitude = to_radians(latitude)
    @longitude = to_radians(longitude)
  end

  def within_kilometers?(start_location, distance)
    distance_between = DistanceCalculator.new(start_location, self)
    distance_between.within_kilometers?(distance)
  end

  private

  def to_radians(degree)
    degree * (Math::PI / 180)
  end

  def valid_coordinates?(latitude, longitude)
    numeric = (latitude.is_a? Numeric) && (longitude.is_a? Numeric)
    valid_range = (-90..90).cover?(latitude) && (-180..180).cover?(longitude)
    numeric && valid_range
  end
end

class Customer
  attr_reader :name, :id, :location

  def initialize(data)
    @name = data["name"]
    @id = data["user_id"]
    @location = Location.new(data["latitude"].to_f, data["longitude"].to_f)
  end

  def within_kilometers?(start_location, distance)
    location.within_kilometers?(start_location, distance)
  end
end

class DistanceCalculator
  EARTH_RADIUS_KM = 6371
  attr_reader :location1, :location2

  def initialize(location1, location2)
    @location1 = location1
    @location2 = location2
  end

  def within_kilometers?(distance_in_kilometers)
    distance_in_kilometers >= distance_between
  end

  def distance_between
    EARTH_RADIUS_KM * central_angle
  end

  private

  def central_angle
    Math.acos(central_angle_cosine)
  end

  def central_angle_cosine
    longitude_delta = location2.longitude - location1.longitude
    a = Math.sin(location1.latitude) * Math.sin(location2.latitude)
    b = Math.cos(location1.latitude) * Math.cos(location2.latitude)

    a + b * Math.cos(longitude_delta)
  end
end

class CustomerProximity
  attr_reader :start_location, :customer_data

  def initialize(data, start_location)
    @customer_data = data
    @start_location = Location.new(start_location["latitude"], start_location["longitude"])
  end

  def within_kilometers(distance)
    customers_within_distance = customer_objects.select do |customer|
      customer.within_kilometers?(start_location, distance)
    end

    display_sorted(customers_within_distance)
  end

  private

  def customer_objects
    customer_data.map do |customer_data|
      Customer.new(customer_data)
    end
  end

  def display_sorted(customers)
    sorted_customers = customers.sort_by(&:id)
    sorted_customers.each do |customer|
      puts "Name: #{customer.name} - ID: #{customer.id}"
    end
  end
end
