def step(start, ending, step)
  i = start
  loop do
    yield(i)
    i + step > ending ? return : i += step
  end
  return i
end

# def step(start, ending, step)
#   start.upto(ending) { |value| yield(value) if ((value - start) % step == 0) }
#   return ending
# end

step(1, 10, 3) { |value| puts "value = #{value}" }
