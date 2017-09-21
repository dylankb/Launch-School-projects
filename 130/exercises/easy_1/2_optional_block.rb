# 1

# def compute
#   return "Does not compute" unless block_given?
#   yield
# end

# compute { 5 + 3 } == 8
# compute { 'a' + 'b' } == 'ab'
# compute == 'Does not compute.'

# 1b

# def compute(arg="")
#   !arg.to_s.empty? ? yield(arg) : yield
# end
#
# a = 5
# p compute(a) { a + 5 + 3 } == 13
# p compute {'a' + 'b'} == "ab"

# 2

# def missing(arr)
#   (arr[0]..arr[-1]).to_a - arr
# end
#
# missing([-3, -2, 1, 5]) == [-1, 0, 2, 3, 4]
# missing([1, 2, 3, 4]) == []
# missing([1, 5]) == [2, 3, 4]
# missing([6]) == []
