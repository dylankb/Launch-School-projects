class Scrabble

  LETTER_POINTS = { :a => 1, :e => 1, :i => 1, :o => 1, :u => 1,
                    :n => 1, :r => 1, :t => 1, :s => 1, :l => 1,
                    :d => 2, :g => 2,
                    :b => 3, :c => 3, :m => 3, :p => 3, 
                    :f => 4, :h => 4, :v => 4, :w => 4, :y => 4,
                    :k => 5,
                    :j => 8, :x => 8,
                    :q => 10, :z => 10,
                  }

  def initialize(word)
    @word = word
  end

  def get_letters
    letters = @word == nil ? [] : @word.gsub(/[^a-zA-Z]/,"").downcase.split("")
  end

  def count_letters
    letters = get_letters
    letters.each_with_object({}) do |letter, letter_count|
      if letter_count.has_key?(letter)
        letter_count[letter] += 1
      else
        letter_count[letter] = 1
      end
    end
  end

  def score
    letter_count = count_letters
    letter_count.inject(0) do |count, (k, v)|
      count += LETTER_POINTS[k.to_sym] * v
    end
  end

  def self.score(word)
    Scrabble.new(word).score
  end
end
