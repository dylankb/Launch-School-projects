# - Comparison method
# - Incrementer method
# - Times method

## Comparison method ##

# def compare(str)
#   puts "Before: #{str} "
#   aftr = yield(str)
#   puts "After: #{aftr}" 
# end

# compare("hi") { |word| puts "nothing to do with anything"}

## Increment method ###

# method definition
# def increment(number)
#   if block_given?
#     yield( number + 1)
#   else
#     number + 1
#   end
# end

# # method invocation
# puts increment(5)  


## Compare method ###

# def increment(number)
#   if block_given?
#     yield(number + 1)
#   else
#     number + 1
#   end
# end

# # method invocation
# puts increment(5)

# Times method ##

def times(num)
  counter = 0
  while counter < num
    yield counter
    counter += 1
  end
  num
end

times(5) do |num|
  puts num
end


