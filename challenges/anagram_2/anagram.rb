class Anagram

  def initialize(string)
    @string = string
  end

  def match(strings_array)
    strings_array.select { |string| is_anagram?(string) } 
  end

  private

  def is_anagram?(other_string)
    number_of_letters_match?(other_string) && unique_word?(other_string) 
  end

  def unique_word?(other_string)
    @string.downcase != other_string.downcase
  end

  def number_of_letters_match?(other_string)
    @string.downcase.chars.sort == other_string.downcase.chars.sort
  end
end
