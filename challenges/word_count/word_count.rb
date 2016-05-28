class Phrase
  
  def initialize(phrase)
    @words = sanitize_input(phrase)
  end

  def word_count
    @words.each_with_object({}) do |word, word_count|
      if word_count.include? word
        word_count[word] += 1
      else
        word_count[word] = 1
      end
    end
  end

private

  def sanitize_input(phrase)
    sanitized_array = phrase.downcase
                            .gsub(/[^\w\s\d,']/,"")
                            .split(/[[:space:]]+|,/)
                            .delete_if {|word| word==""}

    sanitized_array_without_quoted_words = remove_quoted_words(sanitized_array)        
  end

  def remove_quoted_words(array)
    array.map do |word|
      if word[0] == "'" && word[-1] == "'"
        word[1..-2]
      else
        word
      end
    end
  end
end




