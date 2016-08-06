class Scrabble

  LETTER_POINTS = {:a => 1, :e => 1, :i => 1, :o => 1, :u => 1,
                     :n => 1, :r => 1, :t => 1, :s => 1,
                     :d => 2, :g => 2,
                     :b => 3, :c => 3, :m => 3, :p => 3, 
                     :f => 4, :h => 4, :v => 4, :w => 4,
                     :k => 5,
                     :j => 8, :x => 8,
                     :q => 10, :z => 10,
                    }

  def self.count_letters(word)
    letters = word.split("")
    letters.each_with_object({}) do |letter, letter_count|
      if letter_count.has_key?(letter)
        letter_count[letter] += 1
      else
        letter_count[letter] = 1
      end
    end
  end

  def self.score_word(word)
    letter_count = count_letters(word)
    letter_count.inject(0) do |count, (k, v)|
      count += LETTER_POINTS[k.to_sym] * v
    end
  end
end

p Scrabble.score_word("cabbage")