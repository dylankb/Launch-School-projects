class KrispyKreme
  attr_reader :filling_type, :glazing

  def initialize(filling_type, glazing)
    @filling_type = filling_type
    @glazing = glazing
  end

  # Initial solution
  # def to_s
  #   glaze_description = glazing.nil? ? "" : "with #{glazing}"
  #   if filling_type.nil?
  #     puts "Plain #{glaze_description}"
  #   else
  #     puts "#{filling_type} #{glaze_description}"
  #   end
  # end

  def to_s
    glaze_description = glazing.nil? ? "" : "with #{glazing}"
    filling_description = filling_type.nil? ? "Plain" : filling_type
    puts "#{filling_description} #{glaze_description}"
  end
end

donut1 = KrispyKreme.new(nil, nil)
donut2 = KrispyKreme.new("Vanilla", nil)
donut3 = KrispyKreme.new(nil, "sugar")
donut4 = KrispyKreme.new(nil, "chocolate sprinkles")
donut5 = KrispyKreme.new("Custard", "icing")

puts donut1
  # => "Plain"

puts donut2
  # => "Vanilla"

puts donut3
  # => "Plain with sugar"

puts donut4
  # => "Plain with chocolate sprinkles"

puts donut5
  # => "Custard with icing"
