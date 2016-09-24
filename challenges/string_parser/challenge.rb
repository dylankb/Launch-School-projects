class Parser
  attr_reader :input

  def initialize(input_string)
    @input = normalize_input(input_string)
    raise(ArgumentError) if invalid_string?(input_string)
  end

  def normalize_input(string)
    string.gsub(/\s+\./,".")
  end

  def invalid_string?(string)
    too_long?(string) || invalid_chars?(string)
  end

  def too_long?(string)
    string.split(" ").any? do |word|
      word.length > 20
    end
  end

  def invalid_chars?(string)
    string.scan(/([a-zA-Z\s]|\.\z)/).join("") == string
  end

  def odds_reversed
    input.split(" ").map.with_index do |word, index|
      index.odd? ? word.reverse : word
    end.join(" ")
  end
end

string = Parser.new('what. the.')
p string
