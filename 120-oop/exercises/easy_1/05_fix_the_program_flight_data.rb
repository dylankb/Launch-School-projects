# How should this program be improved

class Flight
  attr_accessor :database_handle

  def initialize(flight_number)
    @database_handle = Database.init
    @flight_number = flight_number
  end
end


# @database_handle is an implementation - don't need easy access. Don't provide the unneeded and unwanted attr_accessor since it's an implementation detail
