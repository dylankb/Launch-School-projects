nums = (1..9).to_a

operator_permutations = ["+","-",""].repeated_permutation(8).to_a

answer = operator_permutations.each_with_object([]) do |operators, sum|
  evals = []
  nums.each_with_index do |num, index|
    if operators[index] == ""
      evals << (num.to_s + nums[index+1].to_s).to_i
    else
      evals << num.send(operators[index],nums[index+1]) if nums[index+1]
    end  
  end
  sum << evals.inject(:+)
end

p answer
