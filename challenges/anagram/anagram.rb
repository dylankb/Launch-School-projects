class Anagram
  def self.isAnagram(original, test)
    new_str_hash = count_str_letters(original)
    str_hash = count_str_letters(test)

    new_str_hash == str_hash
  end

  def self.count_str_letters(str)
    str = str.gsub(/\s/,'').downcase.chars

    str_hash = str.each_with_object({}) do |letter, obj|
      obj.key?(letter) ? obj[letter] += 1 : obj[letter] = 1
    end
    str_hash.sort_by { |key, value| value}.to_h
  end
end

#puts Anagram.isAnagram("William Shakespeare", "I am a weakish speller")

