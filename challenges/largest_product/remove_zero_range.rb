RANGE = 2
require 'pry'

string = "110124430245011235"
indexes = string.size.times.select {|index| string[index] == "0"}
ranges = indexes.map {|index| ((index - RANGE)..(index + RANGE)).to_a}

def stranded_number_sets(ranges)
  ranges.each_slice(RANGE).with_index do |range, index|
    gap = [range[0][-1],range[1][0]]
    if (gap[0]..gap[1]).size < RANGE + 3
      return ((gap[0]..gap[1]).to_a - gap)
    end
    nil
  end
end

p ranges
p stranded_number_sets(ranges)

range = (ranges + stranded_number_sets(ranges)).flatten.uniq
p range

def remove_nums_within_range_of_zero(string, range)
  string.chars.delete_if.with_index do |ele, index| 
    range.include? index
  end
end

test = remove_nums_within_range_of_zero(string, range)
p test

# def remove_nums_within_range_of_zero(string, indexes)
#   indexes.each do |zero_index|
#     string.chars.delete_if.with_index.with_object(string) do |(ele, index), acc_string| 
#       ((zero_index - RANGE)..(zero_index + RANGE)).to_a.include? index
#     end
#   end
# end