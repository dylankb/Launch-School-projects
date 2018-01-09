# First attempt

# def divisors(num)
#   range = (1..num/2).to_a
#   results = range.select do |n|
#     result = (num / n.to_f)
#     result.to_i == result
#   end
# end

def divisors(num)
  1.upto(num/2).select { |n| num % n == 0 }.push(num)
end

# More efficient as it's only searching for the divisors greater than 2.

divisors(1) == [1]
p divisors(7) == [1, 7]
divisors(12) == [1, 2, 3, 4, 6, 12]
divisors(98) == [1, 2, 7, 14, 49, 98]
p divisors(99400891) == [1, 9967, 9973, 99400891]
