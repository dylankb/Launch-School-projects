require 'pry'

class Palindromes
  def initialize(hsh)
    @hsh = hsh
    if !@hsh.key?(:min_factor)
      @hsh[:min_factor] = 1
    end
  end

  def generate
    range = (@hsh[:min_factor]..@hsh[:max_factor]).to_a
    perms = range.repeated_permutation(2).to_a

    products = perms.each_with_object({}) do |num, acc|
      acc.merge!(Hash[ num[0] * num[1], [ num[0], num[1] ] ])
    end
    @palindromes = products.select do |k, v|
      is_palindrome?(k)
    end
  end

  def largest
    largest_value = @palindromes.keys.max
    @palindronme = [ largest_value, [@palindromes[largest_value] ] ]
  end

  def value
    @palindrome[0]
  end

  def smallest
  end

  def is_palindrome?(num)
    num.to_s == num.to_s.reverse
  end
end   

palindromes = Palindromes.new(max_factor: 99, min_factor: 10)
palindromes.generate
largest = palindromes.largest

