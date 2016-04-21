class WordProblem

  def initialize(word_problem)
    @operands = get_operands(word_problem)
    @operators = get_operators(word_problem)
    raise ArgumentError if @operators.empty? || @operands.empty?
  end

  def minus
    @operands[0] - @operands[1]
  end

  def plus
    @operands[0] + @operands[1]
  end

  def divided
    @operands[0] / @operands[1]
  end

  def multiplied
    @operands[0] * @operands[1]
  end

  def get_operands(string)
    string.scan(/-?\d+/).map(&:to_i)
  end

  def get_operators(string)
    string.scan(/plus|divided|minus|multiplied/)
  end

  def answer
    @operators.reduce(0) do |acc, operator|
      acc = self.send(operator)
      @operands.shift(2)
      @operands.insert(0, acc)
      acc
    end
  end
end
